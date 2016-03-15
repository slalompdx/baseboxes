== NOTE ON BOX NAMES ==

Dash count indicates level in hierarchy and thus build order -

For instance -

centos-6 <-- base build
centos-6-puppet <-- builds on this
centos-6-puppet-jenkins <-- builds on centos-6-puppet

== Proxies ==
Call packer with -var and then http_proxy and https_proxy (and their capitalized counterparts if you like) to build boxes with proxies.
