ark "mautic" do
  url node[:lw1_mautic][:install][:download_url]
  version node[:lw1_mautic][:install][:version]
  path "/var/www"
  checksum  node[:lw1_mautic][:install][:checksum]
  owner 'apache'
  group 'apache'
  action :put
end

mount "/var/www/html" do
  device "/var/www/mautic"
  fstype "none"
  options "bind,rw"
  action [:mount, :enable]
end

cookbook_file "/etc/httpd/conf.d/mautic.conf" do
  source "httpd/mautic.conf"
end

bash "execute composer install" do
  cwd "/var/www/html"
  user 'apache'
  group 'apache'
  environment "HOME" => "/home/ec2-user"
  code <<-EOL
     /usr/local/bin/composer install --no-dev
     # /usr/local/bin/composer install -v
  EOL
  returns [0, 1]
end
