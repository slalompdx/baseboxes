include stdlib

class { '::rbenv': }
rbenv::plugin { 'sstephenson/ruby-build': latest => true }
rbenv::build { '2.0.0-p647': global => true }
