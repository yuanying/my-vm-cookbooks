
pkgs = %w[git-core debootstrap runit]

pkgs.each do |pkg|
  package pkg
end

directory ::File.dirname(node.nise_bosh.dir) do
  recursive true
end

git node.nise_bosh.dir do
  repository node.nise_bosh.repository
  revision node.nise_bosh.revision
  action :sync
end

ruby_path = File.join(node[:ruby][:prefix_path])
gem_package "bosh_cli" do
  gem_binary File.join(ruby_path, "bin", "gem")
end

bash "Bosh init" do
  cwd node.nise_bosh.dir
  code <<-EOH
  #{node.nise_bosh.dir}/bin/init
  EOH
end


if node.nise_bosh.create_stemcell
  stemcell_path = "/var/vcap/stemcell_base.tar.gz"
  bash "Create Stemcell" do
    cwd File.join("", "tmp")
    code <<-EOH
    #{node.nise_bosh.dir}/bin/gen-stemcell --bosh /vcap/bosh
    EOH

    not_if do
      ::File.exists?(stemcell_path)
    end
  end
end


