yum -y install scl-utils
rpm -ivh https://www.softwarecollections.org/en/scls/rhscl/ruby200/epel-7-x86_64/download/rhscl-ruby200-epel-7-x86_64.noarch.rpm
yum -y install ruby200
echo "#!/bin/bash" > /etc/profile.d/ruby200.sh
echo "source scl_source enable ruby200" >> /etc/profile.d/ruby200.sh
chmod +x /etc/profile.d/ruby200.sh
