xinput list
echo "Choose ID to list props"
read id
xinput list-props "$id"

echo "Set propID"
read prop

echo "Set value"
read val

xinput set-prop "$id" "$prop" "$val"
