#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

# polybar bar >>/tmp/polybar.log 2>&1 & disown

PRIMARY_MONITOR=$(xrandr --query | grep "primary" | cut -d" " -f1)
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		if [ $m = $PRIMARY_MONITOR ]; then
			MONITOR=$m polybar --reload bar &
		else
			MONITOR=$m polybar --reload simplebar &
		fi
	done
else
	polybar --reload bar &
fi

echo "Bars launched..."
