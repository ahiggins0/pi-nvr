#!/bin/bash
cd /mnt/usb/frontdoor
openRTSP -D 1 -c -B 10000000 -b 10000000 -4 -f 15 -Q -F frontdoor-cam -P 3600 -t -K -u <username> <password> "rtsp://<camera-ip-address>:554/cam/realmonitor?channel=1&subtype=0&authbasic=64"
