#!/bin/bash

echo "export http_proxy='http://proxy.standard.com:8080/'" >> /etc/profile
echo "export HTTP_PROXY=\"$http_proxy\"" >> /etc/profile
echo "export https_proxy='http://proxy.standard.com:8080/'" >> /etc/profile
echo "export HTTPS_PROXY=\"$http_proxy\"" >> /etc/profile

