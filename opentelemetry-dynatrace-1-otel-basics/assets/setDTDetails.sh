echo "#=================================#"
echo "# Please enter Git details now    #"
echo "#=================================#"
read -p 'DT API Token (eg. dtc01.***.****): ' DT_API_TOKEN
read -p 'DT Environment URL (with https and no trailing slash eg. https://abc12345.live.dynatrace.com): ' DT_ENVIRONMENT

export DT_API_TOKEN=$DT_API_TOKEN
export DT_ENVIRONMENT=$DT_ENVIRONMENT

echo ""
echo "#=================================#"
echo "         DT Details Set:          "
echo "#=================================#"
echo ""
echo "DT API Token: $DT_API_TOKEN"
echo "DT Environment: $DT_ENVIRONMENT"

echo ""
echo "============================================================="
echo "Made a mistake? Easy. Just click the command again on the left to reset everything."
echo "Everything look good? Proceed with the tutorial..."
echo "============================================================="