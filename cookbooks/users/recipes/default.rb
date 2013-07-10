
node[:groups].each do |g|
  group g
end

node[:users].each do |u|
  user u[:name] do
    gid u[:gid]
    shell u[:shell]
    system u[:system]
  end
end