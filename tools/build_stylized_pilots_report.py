#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build the view-only report from the local pilot brief and reviewed delivery data."""
from pathlib import Path
import argparse
import json

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--task', default='experiments/stylized-local-pilots-20261120')
parser.add_argument('--output', default='docs/stylized-local-pilots.html')
args = parser.parse_args()
TASK = ROOT / args.task
brief = json.loads((TASK / 'brief.json').read_text())
delivery_path = TASK / 'delivery.json'
delivery = json.loads(delivery_path.read_text()) if delivery_path.exists() else {}
audit_path = TASK / 'audits/execution-summary.json'
audit = json.loads(audit_path.read_text()) if audit_path.exists() else {}
games = []
for item in brief['games']:
    ref = item.get('image_url') or item['references'][-1]['image_url']
    source = item.get('source') or item['references'][-1]['source_page']
    games.append({**item, 'reference_image': ref, 'reference_source': source,
                  **delivery.get('games', {}).get(item['id'], {})})
data = json.dumps({'games': games, 'updated': brief.get('updated', brief.get('date', '')),
                   'status': brief['status'], 'review': delivery.get('review', ''),
                   'rejection': delivery.get('rejection', ''),
                   'pipeline_findings': delivery.get('pipeline_findings', []),
                   'title': brief.get('title', '四种风格，先把局部做完整'),
                   'intro': brief.get('intro', ''),
                   'scope_note': brief.get('scope_note', ''),
                   'whitebox': brief.get('whitebox_captures', {}),
                   'usage': audit.get('games', [])}, ensure_ascii=False).replace('</', '<\\/')
page = r'''<!doctype html>
<html lang="zh-CN"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>四种风格 · 局部制作验证</title>
<style>
:root{color-scheme:dark;--bg:#0d1118;--panel:#151c27;--line:#2a3545;--ink:#e9eef7;--muted:#aab8cb;--accent:#9bc7ff}*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--ink);font:15px/1.65 system-ui,-apple-system,"PingFang SC",sans-serif}main{max-width:1520px;margin:auto;padding:36px 30px 70px}h1{font-size:clamp(27px,3.2vw,44px);letter-spacing:-1px;margin:4px 0 10px;line-height:1.2}h2{font-size:25px;margin:5px 0}h3{font-size:16px;margin:0 0 9px}p{margin:8px 0}a{color:var(--accent)}.eyebrow{font-size:12px;letter-spacing:2px;color:var(--accent)}.intro{max-width:900px;color:var(--muted)}.stats{display:flex;gap:8px;flex-wrap:wrap;margin:22px 0 28px}.pill{padding:5px 12px;background:#1c2737;border:1px solid var(--line);border-radius:30px;font-size:12px}.tabs{display:flex;gap:8px;flex-wrap:wrap;padding:14px 0;position:sticky;top:0;background:rgba(13,17,24,.96);z-index:2;border-bottom:1px solid var(--line)}button{font:inherit;color:var(--ink);background:var(--panel);border:1px solid var(--line);border-radius:8px;padding:9px 16px;cursor:pointer}button:hover{border-color:var(--accent)}button[aria-selected=true],button.active{background:var(--accent);color:#0d192b;border-color:var(--accent)}.heading{display:flex;justify-content:space-between;align-items:start;gap:20px;margin:26px 0 20px}.muted{color:var(--muted)}.modes{display:flex;gap:7px;flex-wrap:wrap;margin:15px 0}.compare{display:grid;grid-template-columns:1fr 1fr;gap:16px}.frame{background:var(--panel);border:1px solid var(--line);border-radius:12px;overflow:hidden;margin:0;min-width:0}.frame img{display:block;width:100%;aspect-ratio:16/10;object-fit:contain;background:#080b10;cursor:zoom-in}.frame figcaption{padding:12px 16px;color:var(--muted);font-size:13px}.frame strong{color:var(--ink);display:block}.empty{aspect-ratio:16/10;display:grid;place-items:center;color:var(--muted);padding:30px;text-align:center}.details{display:grid;grid-template-columns:1.2fr 1fr;gap:16px;margin-top:20px}.card{padding:20px 22px;border:1px solid var(--line);border-radius:12px;background:var(--panel)}.card ul{padding-left:20px;margin:8px 0}.card li{margin:7px 0}.strip{display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-top:20px}.strip img{width:100%;aspect-ratio:16/10;object-fit:contain;display:block;background:#080b10;border-radius:6px}.strip button{padding:7px;text-align:left}.strip span{display:block;padding:7px 4px 0;font-size:12px}.catalog{margin-top:38px;overflow:auto}table{width:100%;border-collapse:collapse;font-size:14px;min-width:750px}td,th{text-align:left;vertical-align:top;padding:14px 12px;border-bottom:1px solid var(--line)}th{color:var(--muted);font-weight:500}.note{margin-top:26px;padding-top:20px;border-top:1px solid var(--line);font-size:13px;color:var(--muted)}dialog{width:min(96vw,1800px);max-height:96vh;border:1px solid var(--line);border-radius:10px;background:#0a0d12;color:var(--ink);padding:12px}dialog::backdrop{background:#000c}dialog img{display:block;width:100%;max-height:82vh;object-fit:contain}dialog button{float:right;margin-bottom:8px}#lightbox-label{display:inline-block;padding:8px}.status{white-space:nowrap;font-size:12px;color:#d8c39b;border:1px solid #68573c;padding:5px 10px;border-radius:20px}@media(max-width:850px){main{padding:24px 16px 50px}.compare,.details{grid-template-columns:1fr}.heading{display:block}.status{display:inline-block;margin-top:10px}.tabs{gap:6px}.tabs button{padding:8px 10px}.strip{gap:6px}}
</style></head><body><main>
<div class="eyebrow">ENVIRONMENT ART / LOCAL PILOTS</div>
<h1>四种风格，先把局部做完整</h1>
<p class="intro">从参考、素材小样到可编辑的 Godot 初稿。把原作与同一局部的整体、近景、过渡放在一起看，比较造型、材质、道具关系和光影。当前为方向验证，尚待用户美术验收。</p>
<p id="rejection" role="status" hidden style="border:1px solid #b66d61;background:#331f23;padding:18px;border-radius:10px;color:#ffccc2"></p>
<div class="stats"><span class="pill">4 个独立案例</span><span class="pill">GPT-6.2 Astra · high</span><span class="pill">Godot 4.7.2 · Metal Forward+</span><span class="pill">各自独立目录 / Git</span><span class="pill">实机截图 · 可点击放大</span></div>
<nav class="tabs" id="tabs" aria-label="游戏方向"></nav>
<section id="case"></section>
<section class="catalog"><h3>按类别对比四个案例</h3><div class="modes" id="categories"></div><table><thead><tr><th>游戏</th><th>局部</th><th>主要检查</th><th>当前状态</th></tr></thead><tbody id="summary"></tbody></table></section>
<section class="card" style="margin-top:28px"><h3>这轮对管线的实际观察</h3><ul id="pipeline"></ul><p class="muted">四种参考各一次样本；未做 B 接手试验，也没有 effort 排名。当前图像判断由协调者完成。</p></section>
<section class="catalog"><h3>制作进程用量</h3><p class="muted">耗时含素材下载和串行渲染等待，不含协调、审查和报告制作。缓存输入单列；输出已包含推理 token，不能换算为订阅额度。</p><table><thead><tr><th>制作组</th><th>分钟</th><th>未缓存输入</th><th>缓存输入</th><th>输出</th><th>其中推理</th></tr></thead><tbody id="usage"></tbody></table></section>
<p class="note" id="scope"></p>
</main><dialog id="lightbox"><span id="lightbox-label"></span><button id="close">关闭 ×</button><img id="large" alt="放大的参考或实机截图"></dialog>
<script>
const DATA=__DATA__;
let selected=location.hash.slice(1)||DATA.games[0].id, view='overall', stage='selected';
let evidence=Object.keys(DATA.whitebox||{}).length?'whitebox':'reference';
const labels={overall:'整体',close:'近景',transition:'过渡'};
const esc=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const list=arr=>(arr||[]).map(x=>`<li>${esc(x)}</li>`).join('');
document.title=DATA.title;
document.querySelector('h1').textContent=DATA.title;
if(DATA.intro)document.querySelector('.intro').textContent=DATA.intro;
if(DATA.rejection){const warning=document.getElementById('rejection');warning.hidden=false;warning.textContent=DATA.rejection;document.querySelector('.intro').textContent='历史批次：错误输入的结果保留作追溯，不作为原白盒上的有效产出。';}
function show(){
 const g=DATA.games.find(x=>x.id===selected)||DATA.games[0];selected=g.id;
 document.getElementById('tabs').innerHTML=DATA.games.map(x=>`<button data-game="${esc(x.id)}" aria-selected="${x.id===g.id}">${esc(x.name)}</button>`).join('');
 const chosen=(g.stages||{})[stage]||{label:g.pass_label,captures:g.captures};
 const capture=(chosen.captures||{})[view];
 const leftImage=evidence==='whitebox'?DATA.whitebox[view]:g.reference_image;
 const leftCaption=evidence==='whitebox'?`<strong>原始白盒 · ${labels[view]}</strong>同一机位；17 个原物理构件、碰撞与通路冻结。`:`<strong>原作参考</strong><a href="${esc(g.reference_source)}" target="_blank" rel="noopener">查看来源与归属</a> · ${esc(g.reference_note||g.reference_status)}`;
 const evidenceButtons=Object.keys(DATA.whitebox||{}).length?`<div class="modes" aria-label="左侧对照"><button data-evidence="whitebox" class="${evidence==='whitebox'?'active':''}">左侧：原白盒</button><button data-evidence="reference" class="${evidence==='reference'?'active':''}">左侧：原作参考</button></div>`:'';
 const render=capture?`<img src="${esc(capture)}" alt="${esc(g.name+' · '+labels[view]+'实机图')}" data-zoom="${esc(capture)}" data-label="${esc(g.name+' · '+labels[view])}">`:'<div class="empty">此案例尚未交付可检查的实机初稿</div>';
 const links=(g.links||[]).map(x=>`<a href="${esc(x.url)}">${esc(x.label)}</a>`).join(' · ');
 document.getElementById('case').innerHTML=`<div class="heading"><div><h2>${esc(g.name)}</h2><p class="muted">${esc(g.slice_proposal)}</p></div><span class="status">${esc(g.delivery_status||'制作中')}</span></div><div class="modes" aria-label="检查机位">${Object.keys(labels).map(k=>`<button data-view="${k}" class="${k===view?'active':''}">${labels[k]}</button>`).join('')}</div><div class="modes" aria-label="制作阶段">${Object.entries(g.stages||{}).map(([k,s])=>`<button data-stage="${k}" class="${k===stage?'active':''}">${esc(s.label)}</button>`).join('')}</div>${evidenceButtons}<div class="compare"><figure class="frame"><img src="${esc(leftImage)}" alt="${esc(evidence==='whitebox'?'Original whitebox: '+labels[view]:g.name+' reference')}" data-zoom="${esc(leftImage)}" data-label="${evidence==='whitebox'?'原白盒':'原作参考'}"><figcaption>${leftCaption}</figcaption></figure><figure class="frame">${render}<figcaption><strong>Godot · ${labels[view]}</strong>${esc(chosen.label||'方向初稿')} · ${esc(g.capture_note||'从保存后的场景重新加载出图')}</figcaption></figure></div><div class="strip">${Object.keys(labels).map(k=>(chosen.captures||{})[k]?`<button data-view="${k}" aria-label="查看${labels[k]}"><img src="${esc(chosen.captures[k])}" alt="${labels[k]}缩略图" loading="lazy"><span>${labels[k]}</span></button>`:'').join('')}</div><div class="details"><div class="card"><h3>实图检查（当前交付稿）</h3>${g.findings?`<ul>${list(g.findings)}</ul>`:'<p class="muted">等待实机图；不根据制作说明预判质量。</p>'}<h3>下一步</h3><p>${esc(g.next||'完成代表性初稿并检查三机位。')}</p></div><div class="card"><h3>素材与实现</h3><ul>${list(g.asset_notes||[g.focus])}</ul><p>${links}</p><p class="muted">${esc(g.validation||'导入成功与美术达标分别记录。')}</p></div></div>`;
 document.querySelectorAll('[data-evidence]').forEach(b=>b.onclick=()=>{evidence=b.dataset.evidence;show()});
 document.querySelectorAll('[data-game]').forEach(b=>b.onclick=()=>{selected=b.dataset.game;stage='selected';history.replaceState(null,'','#'+selected);show()});
 document.querySelectorAll('[data-stage]').forEach(b=>b.onclick=()=>{stage=b.dataset.stage;show()});
 document.querySelectorAll('[data-view]').forEach(b=>b.onclick=()=>{view=b.dataset.view;show()});
 document.querySelectorAll('[data-zoom]').forEach(b=>b.onclick=()=>{document.getElementById('large').src=b.dataset.zoom;document.getElementById('lightbox-label').textContent=b.dataset.label;document.getElementById('lightbox').showModal()});
}
const categories={fidelity:'参考贴合',unity:'风格统一',assets:'素材适配',detail:'道具与疏密',lighting:'光影层次'};
let category='fidelity';
function summary(){
 document.getElementById('categories').innerHTML=Object.entries(categories).map(([k,n])=>`<button data-category="${k}" class="${category===k?'active':''}">${n}</button>`).join('');
 document.getElementById('summary').innerHTML=DATA.games.map(g=>`<tr><td>${esc(g.name)}</td><td>${esc(g.slice_proposal)}</td><td>${esc((g.category_notes||{})[category]||'待实图检查')}</td><td>${esc(g.delivery_status||'制作中')}</td></tr>`).join('');
 document.querySelectorAll('[data-category]').forEach(b=>b.onclick=()=>{category=b.dataset.category;summary()});
}
summary();
document.getElementById('pipeline').innerHTML=list(DATA.pipeline_findings);
const num=n=>Number(n).toLocaleString('zh-CN');
const usageRow=(name,r)=>`<tr><td>${esc(name)}</td><td>${num(r.producer_minutes??r.minutes)}</td><td>${num(r.uncached_input_tokens)}</td><td>${num(r.usage.cached_input_tokens)}</td><td>${num(r.usage.output_tokens)}</td><td>${num(r.usage.reasoning_output_tokens)}</td></tr>`;
document.getElementById('usage').innerHTML=DATA.usage.map(r=>{const name=DATA.games.find(g=>g.id===r.game).name;return usageRow(name+' · 初稿含自查',r)+(r.revision?usageRow(name+' · 反馈修订',r.revision):'')}).join('');
document.getElementById('scope').textContent=(DATA.scope_note||'每个案例一组局部样本，参考与资产独立发现；没有同游戏多档对照，不能据此判断最优 effort。目录与 Git 隔离，实际访问记录单独审计。原作图片仅作视觉参考，版权归原权利方；交付素材许可见各工程记录。')+(DATA.review?' '+DATA.review:'');
document.getElementById('close').onclick=()=>document.getElementById('lightbox').close();
show();
</script></body></html>'''
path = ROOT / args.output
path.write_text(page.replace('__DATA__', data))
print(path.relative_to(ROOT))
