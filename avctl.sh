#!/bin/bash
## control audio and video devices
##    @script.name [option] on|off
##
##    on       enables cam and micro
##    off      disables cam and micro
##    toggle   toggle on/off
##
## (c) miraculixx
## License: MIT
# script setup to parse options
script_dir=$(dirname "$0")
script_dir=$(realpath $script_dir)
source $script_dir/easyoptions || exit
# defaults
off_msg='cam + mic OFF'
on_msg='cam + mic ON'
off_icon=/usr/share/icons/breeze-dark/actions/16/im-user-offline.svg
on_icon=/usr/share/icons/breeze-dark/actions/16/im-user-online.svg
SUDO_ASKPASS=${SUDO_ASKPASS:-/usr/lib/openssh/gnome-ssh-askpass}

function mute() {
   pactl list sources short | cut -f1 | xargs -I{} pactl set-source-mute {} 1
}

function unmute() {
   pactl list sources short | cut -f1 | xargs -I{} pactl set-source-mute {} 0
}

function nocam() {
  using_video=$(ls /dev/video* | xargs lsof 2>/dev/null | grep -E ".*[\d].*" | xargs -L1 | cut -d' ' -f2)
  if [[ ! -z $using_video ]]; then
   kill -9 $using_video
  fi
}

function yescam() {
  sudo -A modprobe uvcvideo
}

function seton() {
  yescam
  unmute
  notify-send -i $on_icon "$on_msg"
}

function setoff() {
  nocam
  mute
  notify-send -i $off_icon "$off_msg"
}

function toggle() {
  using_video=$(ls /dev/video* | xargs lsof 2>/dev/null | grep -E ".*[\d].*" | xargs -L1 | cut -d' ' -f2)
  capture_active=$(pactl list sources short | cut -f1 | xargs -L1 pactl get-source-mute | grep "Mute: no" -c)
  if [ ! -z $using_video ] || [ $capture_active -gt 0 ]; then
    setoff
  else
    seton
  fi
}

function main() {
  case "$1" in
    off)
      setoff
      ;;
    on)
      seton
      ;;
    toggle)
      toggle
      ;;
    *)
      parse_options -h
  esac
}

main $1