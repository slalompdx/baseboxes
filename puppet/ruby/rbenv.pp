include stdlib

Rbenv::Gem {
  ruby_version => '2.3.1',
}
class { '::rbenv': }
rbenv::plugin { 'sstephenson/ruby-build': latest => true }
rbenv::build { '2.3.1': global => true }
rbenv::gem { ['rake','serverspec']: }
