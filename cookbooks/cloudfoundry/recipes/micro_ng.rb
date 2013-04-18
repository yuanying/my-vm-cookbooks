
include_recipe "cloudfoundry"

bash "Create micro-ng release" do
  cwd node.cloudfoundry.release.dir
  code <<-EOH
  cp #{node.cloudfoundry.release.dir}/jobs/micro/monit-ng.yml #{node.cloudfoundry.release.dir}/jobs/micro/monit.yml
  bosh -n create release --force
  EOH
end

manifest_path = '/tmp/micro_ng.yml'
template manifest_path do
  source 'micro_ng.yml.erb'
end

bash "Install micro-ng" do
  cwd node.nise_bosh.dir
  code <<-EOH
  bundle install
  yes | bundle exec ./bin/nise-bosh #{node.cloudfoundry.release.dir} #{manifest_path} micro
  EOH
end