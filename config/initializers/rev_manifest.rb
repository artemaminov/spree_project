rev_manifest_path = 'public/rev-manifest.json'

if File.exist?(rev_manifest_path)
  REV_MANIFEST = JSON.parse(File.read(rev_manifest_path))
end
