class { '::wget': }
$orig_packageset =
  [
    'rpmdevtools',
    'glibc-devel',
    'readline-devel',
    'libyaml-devel',
    'ncurses-devel',
    'gdbm-devel',
    'tcl-devel',
    'openssl-devel',
    'libffi-devel',
    'make',
    'gcc',
    'unzip',
    'byacc'
  ]
$homedir = '/home/vagrant'
$package_root = 'ruby2'
$version = '2.3.1'
$release = '1'

if $facts['os']['release']['major'] == '7' {
  $packageset = $orig_packageset + 'compat-db47'
  $packagevar = "${facts['os']['release']['major']}.centos.x86_64"
} else {
  $packageset = $orig_packageset + 'db4-devel'
  $packagevar = "${facts['os']['release']['major']}.x86_64"
}

$packagename = "${homedir}/rpmbuild/RPMS/x86_64/${package_root}-${version}-${release}.el${packagevar}.rpm"

package { $packageset: } ->

file {
  [
    '/home/vagrant/rpmbuild',
    '/home/vagrant/rpmbuild/BUILD',
    '/home/vagrant/rpmbuild/RPMS',
    '/home/vagrant/rpmbuild/SOURCES',
    '/home/vagrant/rpmbuild/SPECS',
    '/home/vagrant/rpmbuild/SRPMS'
  ]:
    ensure => directory,
    owner  => 'vagrant',
    group  => 'vagrant',
} ->

wget::fetch { 'Download spec file':
  source => "https://github.com/slalompdx/ruby/raw/master/ruby-el${facts['os']['release']['major']}.spec",
  destination => '/home/vagrant/rpmbuild/SPECS/ruby.spec',
} ->

wget::fetch { 'Download Ruby bundle':
  source => 'https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz',
  destination => '/home/vagrant/rpmbuild/SOURCES/ruby-2.3.1.tar.gz',
} ->

exec { 'build ruby rpm':
  command => '/usr/bin/rpmbuild -ba --define "_topdir /home/vagrant/rpmbuild" /home/vagrant/rpmbuild/SPECS/ruby.spec',
  user    => 'vagrant',
  cwd     => '/home/vagrant',
  creates => $packagename,
  timeout => 0,
} ->

exec { 'install ruby rpm':
  command => "/usr/bin/yum -y localinstall ${packagename}",
} ->

exec { 'install minimal gems':
  command => '/usr/local/bin/gem install bundler rake serverspec',
}
