== HOW TO USE ==

Clone repo

bundle install

BASE_BUILD=rhel-7 be rake build

== NOTE ON BOX NAMES ==

Dash count indicates level in hierarchy and thus build order -

For instance -

rhel-7 <- base
rhel-7-puppet4 <- next layer
rhel-7-puppet4-ruby <- final layer

FOR RHEL7 - to build the ruby layer, you'll need to add the rhel subscription manager username and password to the script centos/7/ruby.sh

centos-6 <-- base build
centos-6-puppet <-- builds on this
centos-6-puppet-jenkins <-- builds on centos-6-puppet


== Proxies ==
Call packer with -var and then http_proxy and https_proxy (and their capitalized counterparts if you like) to build boxes with proxies.

== Environment variables ==

HTTP_PROXY
HTTPS_PROXY
NO_PROXY
BOX_BUILD - set to the name of a build to build only that box during rake spec
BOX_OVERRIDE - set to true to have rake spec avoid building each box
BOX_FORCE - rebuild packer box even if artifacts are present
