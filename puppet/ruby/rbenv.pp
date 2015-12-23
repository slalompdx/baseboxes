include stdlib

class { '::rbenv': }
rbenv::plugin { 'sstephenson/ruby-build': latest => true }
rbenv::build { '2.2.3': global => true }
