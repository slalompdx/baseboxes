shared_examples 'ruby::init' do
  $ruby_packages =
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
      'byacc',
      'ruby2'
    ]

  $ruby_packages.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  if os['release'] =~ /^7\./
    $release = 'centos.x86_64'
  else
    $release = 'x86_64'
  end

  describe file("/home/vagrant/rpmbuild/RPMS/x86_64/ruby2-2.3.1-1.el7.#{release}.rpm") do
    it { should be_file }
  end

  describe command ('gem list') do
    its(:stdout) { should match /serverspec/ }
    its(:stdout) { should match /bundler/ }
  end
end
