
include_recipe 'rbenv'

rbenv_ruby node[:ruby][:global][:version] do
  ruby_version node[:ruby][:global][:version]
  global true
end
