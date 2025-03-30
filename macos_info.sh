#!/bin/sh

###############################################
#  V1.0 - 02/11/23
#  Thomas Eeles. 
#  MacInfo
#  Script uses SwiftDialog and built in macOS commands to show the user details about their device. 
#  Handy tool for when users are on a call with HelpDesk
#  Tested in Jamf but should work on any MDM.            
###############################################

serial_number="$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')"
hostname="$(hostname)"
UNAME_MACHINE="$(uname -m)"
icon=https://s3-alpha.figma.com/hub/file/369556540/2b78f13e-cbc8-4e7f-95ad-c00d7c135305-cover
current_ip=$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | tr '\n' ',')
jamf_version=$(jamf -version | grep -o 'version=.*' | awk -F '=' '{print $2}')
macOS=$(sw_vers -productVersion)
consoleuser=$(stat -f%Su /dev/console)
currentDate=$(date +%s)
uptime=$(bootDate=$(sysctl -n kern.boottime | awk -F'[ ,]' '{print $4}'); calculateUptimeInDays() { local uptimeInSeconds=$1; local secondsInDay=86400; uptimeInDays=$((uptimeInSeconds / secondsInDay)); echo "$uptimeInDays"; }; uptime=$((currentDate - bootDate)); calculateUptimeInDays "$uptime")
MAC=$(networksetup -getmacaddress Wi-Fi | grep -Eo '([0-9a-fA-F]{2}:){5}([0-9a-fA-F]{2})' )

#Functions 


launchDialog() {
    /usr/local/bin/dialog \
    --title "macOS Settings"  \
    --icon "${icon}"  \
    --iconsize 80 \
    --message "Uptime: "$uptime"<br>LoggedinUser: "$consoleuser"<br>Serial: "$serial_number"<br>Arch: "$UNAME_MACHINE"<br>Hostname: "$hostname"<br>Jamf: "$jamf_version"<br>MacOS: "$macOS"<br>MAC: "$MAC"<br>IP: "$current_ip"" \
    --moveable \
    --centreicon \
    --buttonstyle centre \
    --width 320 \
    --height 450
}

launchDialog

exit 0