FROM simonhutson/centos-7.2
MAINTAINER pureivan

# Download and Install jre
RUN \
yum update -y; \
yum install -y wget; \
yum install -y unzip; \
curl --progress-bar --connect-timeout 30 --junk-session-cookies --insecure --location --max-time 3600 --retry 3 --retry-delay 60 --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jre-8u91-linux-x64.rpm" --output "jre-8u91-linux-x64.rpm" ; \
yum localinstall -y /jre-8u91-linux-x64.rpm; \
rm -f /jre-8u91-linux-x64.rpm; \
yum clean all

# Download and Install quickbuild
WORKDIR /opt/

RUN \
curl http://www.pmease.com/downloads -o qbdownload.html; \
wget `cat qbdownload.html | grep "zip" | sed 's/^.*href=\"//g' | sed 's/\"><i.*$//g' | sed 's/amp\;//g' | sed 's/^/http:\/\/www.pmease.com/'` -O `cat qbdownload.html | grep "zip" | sed 's/^.*file=//g' | sed 's/\&amp.*$//g'` ; \
unzip `cat qbdownload.html | grep "zip" | sed 's/^.*file=//g' | sed 's/\&amp.*$//g'`;\
rm -f `cat qbdownload.html | grep "zip" | sed 's/^.*file=//g' | sed 's/\&amp.*$//g'`;\
rm -f qbdownload.html;

EXPOSE 8810
ENTRYPOINT `ls /opt | grep 'quickbuild'`/bin/server.sh console
