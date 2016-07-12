## install misc packages

package 'git'
package 'postfix'
package 'GeoIP'
package 'tmux'
package 'mysql56-server'

service 'sendmail' do
  action [:stop, :disable]
end

%w[
php56
php56-mysqlnd
php56-gd
php56-mcrypt
php56-mbstring
php56-xmlrpc
php56-soap
php56-intl
php56-opcache
php56-imap
].map do |php_m|
  package php_m
end

ruby_block "update php.ini" do
  block do
    _file = Chef::Util::FileEdit.new('/etc/php.ini')
    _file.search_file_replace_line(/^post_max_size/, "post_max_size = 258M ;")
    _file.search_file_replace_line(/^memory_limit/, "memory_limit = 256M ;")
    _file.search_file_replace_line(/^upload_max_filesize/, "upload_max_filesize = 256M ;")
    _file.search_file_replace_line(/^max_execution_time/, "max_execution_time = 600 ;")
    _file.search_file_replace_line(/^max_execution_time/, "max_execution_time = 600 ;")
    _file.write_file
  end
end

ruby_block "postfix main.cf" do
  block do
    _file = Chef::Util::FileEdit.new('/etc/postfix/main.cf')
    _file.search_file_replace_line(/^#local_recipient_maps =$/, "local_recipient_maps =")
    _file.write_file
  end
end


