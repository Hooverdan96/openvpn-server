# Start from Alpine base image
FROM alpine
LABEL maintainer="Mr.Philipp <d3vilh@github.com>"
LABEL version="0.5.5"

# Set the working directory to /opt/app
WORKDIR /opt/app

RUN apk --no-cache --no-progress upgrade && apk --no-cache --no-progress add bash bind-tools oath-toolkit-oathtool curl ip6tables iptables openvpn easy-rsa

#Install Latest RasyRSA Version
RUN chmod 755 /usr/share/easy-rsa/*

# Copy all files in the current directory to the /opt/app directory in the container
COPY bin /opt/app/bin
COPY docker-entrypoint.sh /opt/app/docker-entrypoint.sh
# Copy initial directory creation program
COPY docker-dir-ini.sh /opt/app/docker-dir-ini.sh

# Make all files in the bin directory executable
RUN chmod +x bin/*; chmod +x docker-entrypoint.sh; chmod +x docker-dir-ini.sh

# Copy template files for later use during execution
RUN mkdir -p /opt/app/template
COPY config /opt/app/template
COPY fw-rules.sh /opt/app/template/fw-rules.sh
COPY openssl-easyrsa.cnf /opt/app/template/openssl-easrsa.cnf

# Move sub-directory creation to entrypoint.sh script
# RUN mkdir -p /opt/app/clients \
#    /opt/app/db \
#    /opt/app/log \
#    /opt/app/pki \
#    /opt/app/staticclients \
#    /opt/app/config

# Add the openssl-easyrsa.cnf file to the easy-rsa directory
COPY openssl-easyrsa.cnf /opt/app/easy-rsa/openssl-easyrsa.cnf

# Expose the OpenVPN port (1194/udp)
EXPOSE 1194/udp

# Set the entrypoint to the docker-entrypoint.sh script, passing in the following arguments:
# $REQ_COUNTRY $REQ_PROVINCE $REQ_CITY $REQ_ORG $REQ_OU $REQ_CN
ENTRYPOINT ["./docker-entrypoint.sh", ]
