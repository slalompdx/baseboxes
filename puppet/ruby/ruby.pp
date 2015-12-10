class { 'ruby':
  rubies => ['rh-ruby22'],
}
ruby::gems { 'rh-ruby22':
  gems => { 'bundler'    => { 'version' => '1.10.6' },
            'rake'       => { 'version' => '10.4.2' },
            'serverspec' => { 'version' => '2.24.3' }
          }
}
