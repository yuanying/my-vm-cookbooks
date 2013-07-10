
execute "apt-get-update" do
  command "apt-get -y update"
  ignore_failure true
  action :run
  # not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
end

execute "apt-get-upgrade" do
  command "apt-get -y -qq -s -o Debug::NoLocking=true upgrade"
  ignore_failure true
  action :run
  # not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
end

node[:apt][:default][:packages].each do |pkg|
  package pkg
end

