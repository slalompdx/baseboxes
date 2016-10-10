#!/bin/bash
#
# This will output any variable prefixed with P_ into a json(ish)
# variables file suitable for use with packer.
# All keys are set to lower case, and have the P_ stripped.
# All values are untouched, but double quoted per json spec
# Arrays and hashes are not handled other than simply
# inserting the string as-is

env | awk 'BEGIN{FS="="; ORS=""; print "{ " } 
  /^P_/{
    if (CT > 0) { print ", " }
    printf "\"%s\": \"%s\"", tolower(substr($1,3)), $2
    CT += 1
  } 
  END{ print " }\n" }
' > /tmp/packer-variables.json

