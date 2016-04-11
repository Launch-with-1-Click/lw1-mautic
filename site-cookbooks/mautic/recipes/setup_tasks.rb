directory "/opt/lw1/tasks" do
  action :create
  recursive true
end

remote_directory "/opt/lw1/fixtures-templates" do
  source "fixtures"
end

remote_directory "/opt/lw1/cfn_appendix" do
  source "cfn_appendix"
end

template "/opt/lw1/tasks/first_boot.rb" do
  source "tasks/first_boot.erb"
end

cookbook_file "/opt/lw1/tasks/date.ini.erb" do
  source "lw1_tasks/date.ini.erb"
end

cookbook_file "/opt/lw1/tasks/local.php.erb" do
  source "lw1_tasks/local.php.erb"
end

cookbook_file "/opt/lw1/tasks/install_amiage.php.erb" do
  source "lw1_tasks/install_amiage.php.erb"
end

cron "setup_mautic_on_init" do
  action :create
  time :reboot
  command "/opt/chef/bin/chef-apply /opt/lw1/tasks/first_boot.rb"
end
