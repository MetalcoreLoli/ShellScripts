#!/bin/sh

status=`sudo systemctl status teamviewerd | grep -o "Active\:\s[a-z]\+" | awk '{print $2}'`

[ $status == "inactive" ] && sudo systemctl start teamviewerd
teamviewer
