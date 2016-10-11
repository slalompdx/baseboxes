== HOW TO USE ==

Clone repo

bundle install

BASE_BUILD=centos-7 bundle exec rake build

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

== NOTE ON WINDOWS BUILDS ==

You will need an updates file locally (to be fixed later) for windows to mount. For now, this needs to be downloaded from Slalom's S3 service to a blobs/ directory within the baseboxes directory.

Download the Windows updates ISO by running:

```
bundle exec rake winblob
```

That command creates the blobs directory and downloads the updates ISO to that directory.

== Proxies ==
Call packer with -var and then http_proxy and https_proxy (and their capitalized counterparts if you like) to build boxes with proxies.

== Environment variables ==

HTTP_PROXY
HTTPS_PROXY
NO_PROXY
BOX_BUILD - set to the name of a build to build only that box during rake spec
BOX_OVERRIDE - set to true to have rake spec avoid building each box
BOX_FORCE - rebuild packer box even if artifacts are present

== Extra environment variables ==

If you set the variable `P_USE_VAR_FILE` packer will be passed the option to use a var-file.  This var file can be populated with environment variables that are prefixed with `P_` by using the script `scripts/common/packer_variables.sh`

This can then be used by vagrant or other builder processes to pass lots of variables into the packer build to set things such as the mirror location, iso checksum, etc.

== WINDOWS BOXES ==

In order to patch Windows offline the WSUS Offline Updater should be used to create an .ISO file of the available updates. A separate .ISO file should be made for each Operating System version by selecting "Create ISO image per selected product and language" option.

WSUS Offline Updater can be downloaded [here](http://download.wsusoffline.net/). It must be downloaded, extracted and run on a Windows system. If using an internal WSUS server, it must be specified in the tool settings prior to downloading the updates.

For more information on how to use the Offline Updater look [here](http://www.wsusoffline.net/docs/).

Once the updates have been downloaded and the .ISO file created it is mounted as a separate DVD drive in VirtualBox. The updates are then applied from the local collection.

== RHEL BOXES ==

You can choose RHN or Satellite. By default the builder will choose RHN. You can override this setting with

UPDATE_SOURCE

which can be set to either "rhn" or "satellite."

If you have set "rhn" the following two variables are used:

RHN_UNAME
RHN_PW

Set these to your Red Hat network credentials prior to building the rhel-7-rhn build.

If you have set "satellite" you will need:

SATELLITE_SERVER
SATELLITE_KEY

SERVER should be the FQDN of your satellite server, and KEY should be your activation key
