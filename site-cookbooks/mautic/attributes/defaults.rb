default[:lw1_mautic][:user] = 'apache'
default[:lw1_mautic][:group] = 'apache'

## Sum = Sha256
default[:lw1_mautic][:install] = {
  version: '1.3.1',
  checksum: "5095cbd8212dc826efb3e0008027e95d4d4a0ded10886a922f5ff8a62955c0c3",
  base_url: "https://github.com/mautic/mautic/archive/"
}

default[:lw1_mautic][:install][:download_url] = [
  node[:lw1_mautic][:install][:base_url],
  "#{node[:lw1_mautic][:install][:version]}.tar.gz"
].join("/")

