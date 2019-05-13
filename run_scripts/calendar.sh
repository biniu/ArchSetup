#! /bin/bash
cal_var=`date +%_d`;
cal | sed s/"\(^\|[^0-9]\)$cal_var"'\b'/'\1${font DejaVu Sans Mono:bold:pixelsize=10}${color2}'"$cal_var"'${font}${color}'/ \
