#!/bin/bash

# ps aux|grep conky|xargs kill
# sleep 0.5

if [ "$1" = '-d' ]; then
    echo "Debug mode"
    echo "Using relative paths"
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    CONF_PATH="$DIR/../conky"
    export CONF_PATH="$DIR/../conky"
    export SCRIPT_PATH="$DIR"
else
    CONF_PATH="$HOME/.config/conky"
    export CONF_PATH="$HOME/.config/conky"
    # TODO(biniu) set for some CONST
    # expot SCRIPT_PATH="$DIR"
fi


echo "$CONF_PATH"


conky -c "$CONF_PATH/conky_calendar"       2>/dev/null &
sleep 0.1
conky -c "$CONF_PATH/connections"          2>/dev/null &
sleep 0.1
conky -c "$CONF_PATH/monitoring_panel"     2>/dev/null &
sleep 0.1
conky -c "$CONF_PATH/conky_rss"            2>/dev/null &
sleep 0.1
conky -c "$CONF_PATH/conky_spotify"        2>/dev/null &
sleep 0.1
conky -c "$CONF_PATH/clock"                2>/dev/null &
sleep 0.1
# TODO(biniu) scripts to do
# gmail
# weather
# system logs
# package to update
# TODO list
# calendar agenda
# NETWORK
#  ip
#  speedtest
# battery
# other RSS
# pocket TO READ
# dropbox usage
