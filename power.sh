response=$((echo "Power Off" && echo "Cancel") | rofi -dmenu)

if [[ $response == "Power Off" ]]; then
	poweroff
fi
