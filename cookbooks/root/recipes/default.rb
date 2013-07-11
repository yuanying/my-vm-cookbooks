if node['proxy']

  http_proxy  = node['proxy']['http_proxy']
  https_proxy = node['proxy']['https_proxy']
  no_proxy    = node['proxy']['no_proxy']

  if http_proxy
    bash "HTTP Proxy to .bashrc" do
      cwd File.join("", "tmp")
      code <<-EOH
      if [ `cat /root/.bashrc | grep "^export http_proxy" -c` -eq 0 ]; then
        echo 'export http_proxy=#{http_proxy}' >> ~/.bashrc
        echo 'export HTTP_PROXY=$http_proxy' >> ~/.bashrc
      else
        echo "HTTP Proxy exists already, skippking..."
      fi
      EOH
    end
  end

  if https_proxy
    bash "HTTPs Proxy to .bashrc" do
      cwd File.join("", "tmp")
      code <<-EOH
      if [ `cat /root/.bashrc | grep "^export https_proxy" -c` -eq 0 ]; then
        echo 'export https_proxy=#{https_proxy}' >> ~/.bashrc
        echo 'export HTTPS_PROXY=$https_proxy' >> ~/.bashrc
      else
        echo "HTTPs Proxy exists already, skippking..."
      fi
      EOH
    end
  end

  if no_proxy
    bash "No Proxy to .bashrc" do
      cwd File.join("", "tmp")
      code <<-EOH
      if [ `cat /root/.bashrc | grep "^export no_proxy" -c` -eq 0 ]; then
        echo 'export no_proxy=#{no_proxy}' >> ~/.bashrc
        echo 'export NO_PROXY=$no_proxy' >> ~/.bashrc
      else
        echo "No Proxy exists already, skippking..."
      fi
      EOH
    end
  end

  if https_proxy
    package 'corkscrew'

    template '/usr/local/bin/socks-gw' do
      mode "0755"
      source 'socks-gw.erb'
    end

    template '/usr/local/bin/socks-ssh' do
      mode "0755"
      source 'socks-ssh.erb'
    end

    bash "GIT Proxy Command to .bashrc" do
      cwd File.join("", "tmp")
      code <<-EOH
      if [ `cat /root/.bashrc | grep "^export GIT_PROXY_COMMAND" -c` -eq 0 ]; then
        echo 'export GIT_PROXY_COMMAND=socks-gw' >> ~/.bashrc
        echo 'export GIT_SSH=socks-ssh' >> ~/.bashrc
      else
        echo "GIT Proxy exists already, skippking..."
      fi
      EOH
    end
  end

end