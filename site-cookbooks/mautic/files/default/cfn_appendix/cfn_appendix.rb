template "/var/www/html/app/config/local.php" do
  local true
  mode  '0600'
  owner "apache"
  group "apache"
  source "/opt/lw1/cfn_appendix/cfn_local.php.erb"
end

bash 'install mautic to rds' do
  cwd "/var/www/html"
  user "apache"
  group "apache"
  code <<-"EOH"
    /usr/bin/php app/console cache:clear --env=prod
    /usr/bin/php app/console doctrine:migrations:status --env=prod --no-interaction
    /usr/bin/php app/console doctrine:schema:create --env=prod --no-interaction
    /usr/bin/php app/console doctrine:migrations:migrate --env=prod --no-interaction
    /usr/bin/php /var/www/html/app/console mautic:iplookup:download --env=prod --no-interaction
    /usr/bin/php app/console doctrine:fixtures:load --env=prod --fixtures=app/bundles/InstallBundle/InstallFixtures/ --no-interaction
    touch /var/www/html/.cfn_fixtures_done
  EOH
  action :run
  creates "/var/www/html/.cfn_fixtures_done"
end

service 'mysqld' do
  action [:stop, :disable]
end

