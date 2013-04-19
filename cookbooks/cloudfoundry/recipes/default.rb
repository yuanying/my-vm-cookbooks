
parent_dir = ::File.dirname(node.cloudfoundry.release.dir)
directory parent_dir do
  recursive true
end

git node.cloudfoundry.release.dir do
  repository node.cloudfoundry.release.repository
  revision node.cloudfoundry.release.revision
  enable_submodules true
  action :sync
end

manifest_path = File.join(parent_dir, 'micro_ng.yml')
template manifest_path do
  source 'micro_ng.yml.erb'
end


