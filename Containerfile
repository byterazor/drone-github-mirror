FROM alpine

#
# some build arguments
#

# the version of the github cli to download and install
ARG GC_VERSION="2.64.0" 

# the userid of the created gh user
ARG UID=1000
# the groupid of the created gh group
ARG GID=1000
# the platform the container is build for
ARG TARGETPLATFORM

# update alpine inside the container image and install required packages
RUN apk update && apk add --no-cache tini bash git curl

# download and install github cli
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi; curl -sS -L -O --output-dir /tmp/ --create-dirs https://github.com/cli/cli/releases/download/v${GC_VERSION}/gh_${GC_VERSION}_linux_${ARCHITECTURE}.tar.gz && tar zxf /tmp/gh_${GC_VERSION}_linux_${ARCHITECTURE}.tar.gz && mv gh_${GC_VERSION}_linux_${ARCHITECTURE}/bin/gh /usr/local/bin/gh && rm -rf gh_${GC_VERSION}_linux_${ARCHITECTURE}

ADD plugin.sh /plugin.sh
RUN chmod a+x /plugin.sh

ENTRYPOINT ["/sbin/tini", "--", "/plugin.sh"]