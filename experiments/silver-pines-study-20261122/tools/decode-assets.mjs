// CC0 source adaptation: decode meshopt + Basis, preserve atlas UVs and PBR maps.
// node tools/decode-assets.mjs DEPENDENCY_ROOT SOURCE_DIR OUTPUT_DIR
import fs from 'node:fs/promises';
import path from 'node:path';
import {createRequire} from 'node:module';
import {pathToFileURL} from 'node:url';
const [deps, source, output] = process.argv.slice(2);
const req = createRequire(path.join(deps, 'package.json'));
const pkg = async n => import(pathToFileURL(req.resolve(n)).href);
const {NodeIO} = await pkg('@gltf-transform/core');
const {ALL_EXTENSIONS} = await pkg('@gltf-transform/extensions');
const {dequantize} = await pkg('@gltf-transform/functions');
const {MeshoptDecoder} = await pkg('meshoptimizer');
const sharp = req('sharp');
const basisPath = path.join(deps, 'node_modules/three/examples/jsm/libs/basis');
await fs.copyFile(path.join(basisPath,'basis_transcoder.js'), path.join(deps,'basis_transcoder.cjs'));
await fs.copyFile(path.join(basisPath,'basis_transcoder.wasm'), path.join(deps,'basis_transcoder.wasm'));
const basis = await req(path.join(deps,'basis_transcoder.cjs'))();
basis.initializeBasis();
await MeshoptDecoder.ready;
const io = new NodeIO().registerExtensions(ALL_EXTENSIONS).registerDependencies({'meshopt.decoder':MeshoptDecoder});
await fs.mkdir(output,{recursive:true});
for (const file of (await fs.readdir(source)).filter(x=>x.endsWith('.glb'))) {
  const doc = await io.read(path.join(source,file));
  for (const texture of doc.getRoot().listTextures()) {
    if (texture.getMimeType() !== 'image/ktx2') continue;
    const ktx = new basis.KTX2File(texture.getImage());
    if (!ktx.isValid() || !ktx.startTranscoding()) throw new Error('Invalid KTX2 '+file);
    const info = ktx.getImageLevelInfo(0,0,0);
    const pixels = new Uint8Array(ktx.getImageTranscodedSizeInBytes(0,0,0,13));
    if (!ktx.transcodeImage(pixels,0,0,0,13,0,-1,-1)) throw new Error('Transcode failed '+file);
    const png = await sharp(pixels,{raw:{width:info.origWidth,height:info.origHeight,channels:4}}).png().toBuffer();
    texture.setImage(png).setMimeType('image/png');
    ktx.close(); ktx.delete();
  }
  await doc.transform(dequantize());
  for(const ext of doc.getRoot().listExtensionsUsed())
    if (['EXT_meshopt_compression','KHR_texture_basisu','KHR_mesh_quantization'].includes(ext.extensionName)) ext.dispose();
  await io.write(path.join(output,file),doc);
  console.log('decoded',file);
}
