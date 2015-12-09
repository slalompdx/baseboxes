class { 'ruby':
  rubies => ['rh-ruby22'],
}
ruby::gems { 'rh-ruby22':
  gems => { 'bundler' => { 'version' => '1.10.6' } }
}
