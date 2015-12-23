include stdlib

Rbenv::Gem {
  ruby_version => '2.2.2',
}
class { '::rbenv': }
rbenv::plugin { 'sstephenson/ruby-build': latest => true }
rbenv::build { '2.2.2': global => true }
rbenv::gem { ['rake','serverspec']: }
