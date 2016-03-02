default[:lw1_mautic][:user] = 'apache'
default[:lw1_mautic][:group] = 'apache'

## Sum = Sha256
default[:lw1_mautic][:install] = {
  version: '1.3.0',
  checksum: "2304437143043a999d26e2dcd7d8d1464621bfce6a1703d27ebdec5502e503cc",
  base_url: "https://github.com/mautic/mautic/archive/"
}

default[:lw1_mautic][:install][:download_url] = [
  node[:lw1_mautic][:install][:base_url],
  "#{node[:lw1_mautic][:install][:version]}.tar.gz"
].join("/")

