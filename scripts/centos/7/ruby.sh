#!/bin/bash

puppet module install maestrodev-wget
puppet apply -v /tmp/ruby.pp
