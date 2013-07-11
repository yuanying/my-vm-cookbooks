
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby node[:rbenv_ruby][:global][:version] do
  ruby_version node[:rbenv_ruby][:global][:version]
  global true
end
