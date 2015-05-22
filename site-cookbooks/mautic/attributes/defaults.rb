default[:lw1_mautic][:user] = 'apache'
default[:lw1_mautic][:group] = 'apache'

## Sum = Sha256
default[:lw1_mautic][:install] = {
  version: '1.0.5',
  checksum: "6bebc3210e1d218447cd6569b2c64b8b7e77336872c21ed2e67c6632d2dfeac7",
  base_url: "https://github.com/mautic/mautic/archive/"
}

default[:lw1_mautic][:install][:download_url] = [
  node[:lw1_mautic][:install][:base_url],
  "#{node[:lw1_mautic][:install][:version]}.tar.gz"
].join("/")

