default[:lw1_mautic][:user] = 'apache'
default[:lw1_mautic][:group] = 'apache'

## Sum = Sha256
default[:lw1_mautic][:install] = {
  version: '1.4.0',
  checksum: "038bdd0c50398a00a864dd5b6b2cc37cb601c0a1f9105dc3f25327edfde57a09",
  base_url: "https://github.com/mautic/mautic/archive/"
}

default[:lw1_mautic][:install][:download_url] = [
  node[:lw1_mautic][:install][:base_url],
  "#{node[:lw1_mautic][:install][:version]}.tar.gz"
].join("/")

