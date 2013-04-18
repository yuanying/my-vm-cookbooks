
git node.cloudfoundry.release.dir do
  repository node.cloudfoundry.release.repository
  revision node.cloudfoundry.release.revision
  enable_submodules true
  action :sync
end

