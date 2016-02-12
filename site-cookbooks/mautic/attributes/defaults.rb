default[:lw1_mautic][:user] = 'apache'
default[:lw1_mautic][:group] = 'apache'

## Sum = Sha256
default[:lw1_mautic][:install] = {
  version: '1.2.4',
  checksum: "da979fbc030c6d6e321d57420db2ced4e3a62ef1afdde136d214df4af4a8c7da",
  base_url: "https://github.com/mautic/mautic/archive/"
}

default[:lw1_mautic][:install][:download_url] = [
  node[:lw1_mautic][:install][:base_url],
  "#{node[:lw1_mautic][:install][:version]}.tar.gz"
].join("/")

