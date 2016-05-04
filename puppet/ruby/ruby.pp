class { 'ruby':
  rubies => ['rh-ruby22'],
}
ruby::gems { 'rh-ruby22':
  gems => { 'bundler'    => { 'version' => '1.11.2' },
            'rake'       => { 'version' => '11.1.2' },
            'serverspec' => { 'version' => '2.33.0' }
          }
}
