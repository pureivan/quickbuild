FROM simonhutson/centos-7.2
MAINTAINER pureivan

# Download and Install jre
RUN yum update -y && \
yum install -y wget && \
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jre-7u80-linux-x64.rpm" && \
yum localinstall -y /jre-7u80-linux-x64.rpm && \
rm -f /jre-7u80-linux-x64.rpm && \
yum clean all

# Download and Install quickbuild
WORKDIR /opt/

RUN \
curl http://www.pmease.com/downloads -o qbdownload.html; \
wget `cat qbdownload.html | grep "zip" | sed 's/^.*href=\"//g' | sed 's/\"><i.*$//g' | sed 's/amp\;//g' | sed 's/^/http:\/\/www.pmease.com/'` -O `cat qbdownload.html | grep "zip" | sed 's/^.*file=//g' | sed 's/\&amp.*$//g'`
unzip `cat qbdownload.html | grep "zip" | sed 's/^.*file=//g' | sed 's/\&amp.*$//g'`;\
rm -f `cat qbdownload.html | grep "zip" | sed 's/^.*file=//g' | sed 's/\&amp.*$//g'`;\
rm -f qbdownload.html;\

EXPOSE 8810
ENTRYPOINT `ls /opt | grep 'quickbuild'`/server.sh console
