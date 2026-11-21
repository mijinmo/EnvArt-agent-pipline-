#!/usr/bin/env python3
"""Install pinned Godot AI and a workspace-local Codex entry; never launch Godot.

Python 3.9+ standard library. See docs/godot-ai-mcp.md before activation.
The add-on remains inactive until enabled in the production editor.
"""
import argparse
import hashlib
import io
import json
from pathlib import Path, PurePosixPath
import re
import shutil
import subprocess
import tempfile
from urllib.request import urlopen
from zipfile import ZipFile

ROOT = Path(__file__).resolve().parents[1]
LOCK = json.loads(Path(__file__).with_name("godot_ai.lock.json").read_text())
NAME = "godot_ai_envart"
BEGIN = "# BEGIN EnvArt Godot AI (tools/setup_godot_ai.py)"
END = "# END EnvArt Godot AI"


def uv_args(port, ws_port):
    return [
        "--isolated", "--no-config", "--no-env-file", "--no-sources", "--no-build",
        "--index-strategy", "first-index", "--keyring-provider", "disabled",
        "--exclude-newer", LOCK["dependency_cutoff"],
        "--exclude-newer-package", "godot-ai=false",
        "--python", LOCK["python_request"],
        "--index", "https://pypi.org/simple", "--default-index", "https://pypi.org/simple",
        "--find-links", "https://pypi.org/simple/godot-ai/", "--link-mode", "copy",
        "--from", "godot-ai==" + LOCK["version"], "godot-ai", "attach",
        "--port", str(port), "--ws-port", str(ws_port), "--disable-telemetry",
    ]


def config_text(old, command, args, disabled):
    block = "\n".join([
        BEGIN, "[mcp_servers." + NAME + "]",
        "command = " + json.dumps(command), "args = " + json.dumps(args),
        "enabled = " + ("false" if disabled else "true"),
        "startup_timeout_sec = 90", "tool_timeout_sec = 90",
        "enabled_tools = " + json.dumps(LOCK["enabled_tools"]),
        "[mcp_servers." + NAME + ".env]", 'GODOT_AI_DISABLE_TELEMETRY = "1"', END,
    ])
    if BEGIN in old or END in old:
        if old.count(BEGIN) != 1 or old.count(END) != 1 or old.index(BEGIN) >= old.index(END):
            raise ValueError("Malformed managed block; preserve config and inspect it manually")
        start, end = old.index(BEGIN), old.index(END) + len(END)
        remainder = old[:start] + old[end:]
        if re.search(r"(?m)^\s*\[.*\b" + NAME + r"\b", remainder):
            raise ValueError("Another entry uses our server name; config left untouched")
        return old[:start] + block + old[end:]
    if re.search(r"(?m)^\s*\[.*\b" + NAME + r"\b", old):
        raise ValueError("Existing unmanaged Godot AI entry; config left untouched")
    return old + ("\n\n" if old else "") + block + "\n"


def install_archive(project, data):
    if hashlib.sha256(data).hexdigest() != LOCK["archive_sha256"]:
        raise ValueError("Release archive SHA-256 mismatch; nothing installed")
    dest = project / "addons/godot_ai"
    files = {}
    with ZipFile(io.BytesIO(data)) as archive:
        for entry in archive.infolist():
            if entry.is_dir():
                continue
            path = PurePosixPath(entry.filename)
            if path.parts[:2] != ("addons", "godot_ai") or ".." in path.parts:
                raise ValueError("Unexpected archive path")
            files[Path(*path.parts[2:])] = archive.read(entry)
    if dest.exists():
        if not all((dest / p).is_file() and (dest / p).read_bytes() == b for p, b in files.items()):
            raise ValueError("Existing add-on differs; do not overlay it. Preserve it and review the upgrade.")
        print("Pinned add-on already present; retained existing files.")
        return
    dest.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix=".godot-ai-stage-", dir=dest.parent) as stage:
        tree = Path(stage) / "godot_ai"
        for path, content in files.items():
            target = tree / path
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(content)
        tree.rename(dest)
    print("Installed verified add-on:", dest)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--workspace", type=Path, default=ROOT, help="Codex workspace root")
    parser.add_argument("--project", type=Path, default=Path("GodotProject/envart-pipline"),
                        help="Godot directory, relative to workspace or absolute")
    parser.add_argument("--archive", type=Path, help="Use an already downloaded pinned ZIP")
    parser.add_argument("--http-port", type=int, default=8000)
    parser.add_argument("--ws-port", type=int, default=9500)
    parser.add_argument("--disabled", action="store_true", help="Register but don't start MCP in new sessions")
    parser.add_argument("--prewarm", action="store_true", help="Install Python dependencies via attach --help")
    args = parser.parse_args()
    workspace = args.workspace.resolve()
    project = (workspace / args.project).resolve()
    if not (project / "project.godot").is_file():
        parser.error("--project must contain project.godot")
    if not all(1024 <= p <= 65535 for p in (args.http_port, args.ws_port)) or args.http_port == args.ws_port:
        parser.error("Choose distinct ports in 1024..65535")
    uvx = shutil.which("uvx")
    if not uvx:
        parser.error("Install uv >= " + LOCK["uv_minimum"] + " first: https://docs.astral.sh/uv/")
    result = subprocess.run([uvx, "--version"], check=True, capture_output=True, text=True)
    version = re.search(r"(\d+)\.(\d+)\.(\d+)", result.stdout)
    minimum = tuple(map(int, LOCK["uv_minimum"].split(".")))
    if not version or tuple(map(int, version.groups())) < minimum:
        parser.error("Upgrade uv to >= " + LOCK["uv_minimum"])
    config = workspace / ".codex/config.toml"
    old = config.read_text() if config.exists() else ""
    command_args = uv_args(args.http_port, args.ws_port)
    new = config_text(old, uvx, command_args, args.disabled)
    if args.archive:
        data = args.archive.read_bytes()
    else:
        with urlopen(LOCK["archive_url"], timeout=60) as response:
            data = response.read()
    install_archive(project, data)
    if new != old:
        config.parent.mkdir(parents=True, exist_ok=True)
        if old:
            backup = config.with_name("config.toml.envart-backup")
            if not backup.exists():
                backup.write_text(old)
                backup.chmod(0o600)
        config.write_text(new)
        config.chmod(0o600)
    if args.prewarm:
        subprocess.run([uvx] + command_args + ["--help"], check=True, timeout=180)
    print("Configured:", config, "(disabled)" if args.disabled else "(enabled)")
    print("No Godot process launched; project.godot unchanged.")
    print("On the production machine, enable Godot AI in Project Settings > Plugins.")
    print("Then list sessions and verify the full project path before selecting an exact session_id.")


if __name__ == "__main__":
    main()
