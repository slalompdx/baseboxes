	include stdlib

  class { '::rbenv': }
  rbenv::plugin { 'sstephenson/ruby-build': latest => true }
  rbenv::build { '2.0.0-p647': global => true }

	$jenkins_config = {
		'JENKINS_JAVA_OPTIONS' => { 'value' => '-Djava.awt.headless=true -XX:MaxPermSize=512m' },
	}

  class { '::firewall':
    ensure => stopped,
  }

	class { '::jenkins':
		repo               => false,
    executors          => 8,
		config_hash        => $jenkins_config,
    configure_firewall => true,
	}
  yumrepo {'jenkins':
    descr    => 'Jenkins',
    baseurl  => 'http://pkg.jenkins-ci.org/redhat/',
    gpgcheck => 1,
    gpgkey   => 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key',
    enabled  => 1,
  }


  if !defined(Package['openssl-devel']) {
    package { 'openssl-devel': }
  }
  if !defined(Package['readline-devel']) {
    package { 'readline-devel': }
  }
  if !defined(Package['zlib-devel']) {
    package { 'zlib-devel': }
  }
  jenkins::plugin { [
    'ansicolor',

    'credentials',
    'credentials-binding',
    'plain-credentials',
    'workflow-step-api',

    'job-dsl',

    'copy-project-link',

    'rbenv',
    'ruby-runtime',

    'ssh-agent',

    'git',
    'git-client',
    'scm-api',
    'mailer',
    'token-macro',
    'matrix-project',
    'ssh-credentials',

    'parameterized-trigger',
    'subversion',
    'promoted-builds',
    'conditional-buildstep',

    'build-flow-plugin',
    'buildgraph-view',

    'groovy-postbuild',
    'script-security',

    'multiple-scms',
    'ws-cleanup',

    'gradle',
    'envinject',

    'global-build-stats',

    'rebuild'
  ]: }
  jenkins::job { 'seed':
    config => template('/vagrant/puppet/templates/seed.xml.erb')
  }

