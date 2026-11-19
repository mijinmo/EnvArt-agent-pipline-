#!/usr/bin/env python3
"""Neutral per-project import/capture request. No art decisions or peer paths."""
import json, sys, time, uuid
from pathlib import Path

root = Path(__file__).resolve().parent
mode = sys.argv[1] if len(sys.argv) > 1 else ''
if mode not in ('import', 'capture') or (mode == 'capture' and len(sys.argv) != 4):
    raise SystemExit('Usage: python3 render.py import | capture scene.tscn captures/NEW-NAME')
request = {'mode': mode}
if mode == 'capture':
    request.update(scene=sys.argv[2], output=sys.argv[3])
queue = root / '.work/render'
(queue / 'requests').mkdir(parents=True, exist_ok=True)
(queue / 'responses').mkdir(parents=True, exist_ok=True)
key = uuid.uuid4().hex
temporary = queue / 'requests' / (key + '.tmp')
temporary.write_text(json.dumps(request))
temporary.rename(temporary.with_suffix('.json'))
response = queue / 'responses' / (key + '.json')
print('Own-project rendering request submitted:', key, flush=True)
for _ in range(900):
    if response.exists():
        result = json.loads(response.read_text())
        print(json.dumps(result, ensure_ascii=False), flush=True)
        if result.get('log'):
            print((root / result['log']).read_text(errors='replace')[-14000:])
        raise SystemExit(result.get('exit_code', 1))
    time.sleep(1)
raise SystemExit('Rendering response timeout; request is retained. Report this technical issue; do not inspect other directories.')
