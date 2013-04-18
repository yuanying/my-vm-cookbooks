
bundler_version   = node[:gems][:bundler][:version]
rake_version      = node[:gems][:rake][:version]
ruby_path         = File.join(node[:ruby][:prefix_path])

ruby_build_ruby node[:ruby][:version] do
  prefix_path ruby_path
end

gem_package "bundler" do
  version bundler_version
  gem_binary File.join(ruby_path, "bin", "gem")
end

gem_package "rake" do
  version rake_version
  gem_binary File.join(ruby_path, "bin", "gem")
end

