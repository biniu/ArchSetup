#!/bin/bash
#ps aux|grep conky |xargs kill 
sleep 1

conky -c ~/.config/conky/conky_calendar       2>/dev/null &
sleep 0.1
conky -c ~/.config/conky/connections          2>/dev/null &
sleep 0.1
conky -c ~/.config/conky/monitoring_panel     2>/dev/null &
sleep 0.1
conky -c ~/.config/conky/conky_rss            2>/dev/null &
sleep 0.1
# conky -c ~/.config/conky/conky_todo           2>/dev/null &
sleep 0.1
conky -c ~/.config/conky/conky_spotify        2>/dev/null &
sleep 0.1
# conky -c ~/.config/conky/conky_taskWarrior    2>/dev/null &
sleep 0.1
conky -c ~/.config/conky/clock                2>/dev/null &
sleep 0.1
