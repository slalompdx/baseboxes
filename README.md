== NOTE ON BOX NAMES ==

Dash count indicates level in hierarchy and thus build order -

For instance -

centos-6 <-- base build
centos-6-puppet <-- builds on this
centos-6-puppet-jenkins <-- builds on centos-6-puppet

== Proxies ==
Call packer with -var and then http_proxy and https_proxy (and their capitalized counterparts if you like) to build boxes with proxies.

== Environment variables ==

HTTP_PROXY
HTTPS_PROXY
NO_PROXY
BASE_BUILD = set to the name of the build you want
BUILDER = defaults to 'vmware,virtualbox'
FORMAT = defaults to 'iso' - 'ovf' gets special treatment with vmware
