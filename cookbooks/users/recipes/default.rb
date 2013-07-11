
node[:groups].each do |g|
  group g
end

node[:users].each do |u|

  home_dir = "/home/#{u[:name]}"

  user u[:name] do
    gid u[:gid]
    shell u[:shell]
    system u[:system]
    home home_dir
    supports :manage_home => true
  end

  if /zsh/ =~ u[:shell]
    template "#{home_dir}/.zshenv" do
      mode "0644"
      source 'zshenv.erb'
    end

    template "#{home_dir}/.zshrc" do
      mode "0644"
      source 'zshrc.erb'
    end
  end
end