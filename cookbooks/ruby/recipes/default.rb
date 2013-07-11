
include_recipe 'rbenv'
include_recipe "rbenv::ruby_build"

rbenv_ruby node[:ruby][:global][:version] do
  ruby_version node[:ruby][:global][:version]
  global true
end
