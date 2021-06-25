#! /bin/bash

systemctl stop microsocks
rm -r /opt/microsocks
rm /etc/systemd/system/microsocks.service
systemctl daemon-reload
echo ""
echo "microsocks removed."
