#!/run/current-system/sw/bin/bash
sinks=`pactl list sinks short`
sIFS=$IFS
regex="^[0-9]*.+alsa(.+)PipeWire"
sink=$((IFS=$'\n'
for e in $sinks; do
	# echo `expr "$e" : '^\.[0-9]*\([a-z]*\)'`
	if [[ "$e" =~ $regex ]]; then
		name=${BASH_REMATCH[1]}
		echo "alsa${name}"
	fi

	# echo `expr "$e" : '\([0-9]+\)'`
	# echo "--------------------"
done
IFS=$sIFS) | rofi -dmenu)
if [[ $sink ]]; then
	pactl set-default-sink $sink
else
	notify-send "No audio device selected"
fi
