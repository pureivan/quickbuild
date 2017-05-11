FROM jeanblanchard/java:jre-8u131
MAINTAINER pureivan

# Download and Install 
RUN \
apk add --update curl;\
apk update && apk add ca-certificates && update-ca-certificates && apk add openssl;

# Download and Install quickbuild
WORKDIR /opt/

RUN \
curl https://www.pmease.com/quickbuild/downloads -o qbdownload.html; \
wget `cat qbdownload.html | grep "zip" | sed 's/^.*href=\"//g' | sed 's/\"><i.*$//g' | sed 's/amp\;//g' | sed 's/^/http:\/\/www.pmease.com/'` -O `cat qbdownload.html | grep "zip" | sed 's/^.*href=\"//g' | sed 's/\"><i.*$//g' | sed 's/^.*\///g'` ; \
unzip `cat qbdownload.html | grep "zip" | sed 's/^.*href=\"//g' | sed 's/\"><i.*$//g' | sed 's/^.*\///g'`;\
rm -f `cat qbdownload.html | grep "zip" | sed 's/^.*href=\"//g' | sed 's/\"><i.*$//g' | sed 's/^.*\///g'`;\
apk del curl; \
apk del ca-certificates; \
apk del openssl; \
rm -f qbdownload.html;\
rm -rf /var/cache/apk/*;

EXPOSE 8810
ENTRYPOINT `ls /opt | grep 'quickbuild'`/bin/server.sh console
