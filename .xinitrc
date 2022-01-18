#!/bin/sh
picom --experimental-backends &

# nvidia vsync totally optional encourage to remove this section if you dont use nvidia-settings
s="$(nvidia-settings -q CurrentMetaMode -t)"

if [[ "${s}" != "" ]]; then
  s="${s#*" :: "}"
  nvidia-settings -a CurrentMetaMode="${s//\}/, ForceCompositionPipeline=On\}}"
fi


xrandr --output HDMI-0 --primary --mode 1920x1080 --rate 74.97 --output eDP-1-1 --mode 1920x1080 --rate 60.03 --left-of HDMI-0  ;

awesome;

nitrogen --restore
