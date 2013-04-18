
pkgs = %w[build-essential libssl-dev lsof
strace bind9-host dnsutils tcpdump iputils-arping
curl wget libcurl3 libcurl3-dev bison libreadline6-dev
libxml2 libxml2-dev libxslt1.1 libxslt1-dev zip unzip
nfs-common flex psmisc apparmor-utils iptables sysstat
rsync openssh-server traceroute libncurses5-dev quota
libaio1 gdb tripwire libcap2-bin libyaml-dev
debootstrap runit]

pkgs.each do |pkg|
  package pkg
end

blacklist_file = '/etc/logrotate.d/nise_bosh'
cookbook_file blacklist_file do
  source 'logrotate.conf'
  mode "0644"
end

bash "Creating user: vcap" do
  cwd File.join("", "tmp")
  code <<-EOH
  if [ `cat /etc/passwd | cut -f1 -d ":" | grep "^vcap$" -c` -eq 0 ]; then
      addgroup --system admin
      adduser --disabled-password --gecos Ubuntu vcap

      for grp in admin adm audio cdrom dialout floppy video plugdev dip
      do
          adduser vcap $grp
      done
  else
      echo "User vcap exists already, skippking adduser..."
  fi
  EOH
end

git node.nise_bosh.dir do
  repository node.nise_bosh.repository
  revision node.nise_bosh.revision
  action :sync
end

ruby_path         = File.join(node[:ruby][:prefix_path])
gem_package "bosh_cli" do
  gem_binary File.join(ruby_path, "bin", "gem")
end

if node.nise_bosh.create_stemcell
  stemcell_path = "/var/vcap/stemcell_base.tar.gz"
  bash "Create Stemcell" do
    cwd File.join("", "tmp")
    code <<-EOH
    #{node.nise_bosh.dir}/bin/gen-stemcell --bosh /home/vcap/bosh
    EOH

    not_if do
      ::File.exists?(stemcell_path)
    end
  end
end


