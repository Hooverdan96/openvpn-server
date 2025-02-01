#!/bin/bash
set -e

# Additional Variable
CFG_TMPLT_DIR=/opt/app/template
echo "Template files path: $CFG_TMPLT_DIR"

# create initial directories in mapped volume if they don't exist
if [ ! -d $OPENVPN_DIR/config ]; then
    mkdir $OPENVPN_DIR/config
    cp $CFG_TMPLT_DIR/* $OPENVPN_DIR/config
fi
if [ ! -d $OPENVPN_DIR/clients ]; then
    mkdir $OPENVPN_DIR/clients
fi
if [ ! -d $OPENVPN_DIR/db ]; then
    mkdir $OPENVPN_DIR/db
fi
if [ ! -d $OPENVPN_DIR/log ]; then
    mkdir $OPENVPN_DIR/log
fi
if [ ! -d $OPENVPN_DIR/staticclients ]; then
    mkdir $OPENVPN_DIR/staticclients
fi
if [ ! -d $OPENVPN_DIR/pki ]; then
    mkdir $OPENVPN_DIR/pki
fi

# if server.conf doesn't exist, pull from template directory as a starting point
if [ ! -f $OPENVPN_DIR/server.conf ]; then
   cp $OPENVPN_DIR/template/server.conf $OPENVPN_DIR/server.conf
fi
