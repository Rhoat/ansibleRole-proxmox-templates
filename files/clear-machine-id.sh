#!/bin/bash

# Clear machine-id
if [ -f /etc/machine-id ]; then
    cat /dev/null > /etc/machine-id
fi

if [ -f /var/lib/dbus/machine-id ]; then
    rm -f /var/lib/dbus/machine-id
fi

# Linking /var/lib/dbus/machine-id to /etc/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id