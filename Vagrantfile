# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

if Vagrant::VERSION == "1.7.2"
  synced_folder_file = File.expand_path("../.vagrant/machines/default/aws/synced_folders", __FILE__)
  File.unlink(synced_folder_file) if File.exists?(synced_folder_file)
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dummy"
  config.omnibus.chef_version = :latest

  config.vm.synced_folder ".", "/vagrant", type: "rsync",
    rsync__exclude: [
      '.vagrant/',
      '.git/',
      'tmp/',
      'packer_cache/'
  ]

  ## AWS
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.keypair_name = ENV['AWS_EC2_KEYPAIR']
    aws.user_data = "#!/bin/bash\nsed -i -e 's/^Defaults.*requiretty/# Defaults requiretty/g' /etc/sudoers"

    aws.region = ENV['AWS_REGION']
    aws.instance_type = 'c3.large'
    case ENV['AWS_REGION']
    when 'ap-northeast-1'
      aws.ami = 'ami-c7f90ec7' # Amazon Linux AMI 2015.03.0 (HVM)
    when 'us-east-1'
      aws.ami = 'ami-10cae778' # Amazon Linux AMI 2015.03.0 (HVM)
    else
      raise "Unsupported region #{ENV['AWS_REGION']}"
    end

    aws.tags = {
      'Name' => 'Mautic 1.0.5 (Develop)'
    }
    override.ssh.username = "ec2-user"
    override.ssh.private_key_path = ENV['AWS_EC2_KEYPASS']
  end

  config.ssh.pty = true

  ## Sction Provisioning
  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.provision "file", source: ".composer/auth.json", destination: ".composer/auth.json"
  config.vm.provision :chef_zero do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.json = {
      "composer" => {
        "owner" => "root",
        "group" => "apache"
      }
    }
    chef.add_recipe 'simplelog_handler::default'
    chef.add_recipe 'mautic::pre_packages'
    chef.add_recipe 'composer::default'
    chef.add_recipe 'mautic::mautic'
    chef.add_recipe 'mautic::setup_tasks'
  end

end
