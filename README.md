# pi-nvr
Simple RTSP stream recorder using OpenRTSP on an rpi

## Installing OpenRTSP
```
sudo apt update
sudo apt install liblivemedia-dev libssl-dev
wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz
tar -xvf live555-latest.tar.gz
cd live
./genMakefiles linux
sudo make
sudo make install
```
```
https://github.com/rgaufman/live555/issues/45

thank you, my env is Ubuntu20.04 and live.2023.07.24.tar.gz, so i edit the config.linux-64bit, 
Added -DNO_STD_LIB at the end of the first line, Modify to 
COMPILE_OPTS =		$(INCLUDES) -m64  -fPIC -I/usr/local/include -I. -O2 -DSOCKLEN_T=socklen_t -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 -DNO_STD_LIB

*** Add the -DNO_STD_LIB to live/UsageEnvironment/Makefile and live/BasicUsageEnvironment/Makefile
```

## Cronjobs
```
0 */12 * * * /usr/bin/sh /home/pi/organize.sh # Moves .mp4 files to nested directory organized by date
0 * * * * /usr/bin/sh /home/pi/file-check.sh # Checks the recording directory to see if any files are stuck and restarts the frontdoor-cam service
0 1 * * 0 /usr/bin/sh reboot
0 1 * * */4 /usr/bin/sh reboot
```

## Creating The OpenRTSP Service
`vi /lib/systemd/system/frontdoor-cam.service`
Service:
```
[Unit]
Description=frontdoor cam service
After=NetworkManager.service

[Service]
ExecStart=/home/pi/frontdoor-cam.sh
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
```
Enable service:
```
sudo chmod 644 /lib/systemd/system/frontdoor-cam.service
sudo systemctl daemon-reload
sudo systemctl enable frontdoor-cam.service
sudo systemctl start frontdoor-cam.service
```

## Creating Storage Mount Point - Auto Mount
https://www.shellhacks.com/raspberry-pi-mount-usb-drive-automatically/

## To Do
- Do all this with Ansible
