#!/bin/bash

set -Ceu

conf=$(cat config.json)
res=$(echo "$conf" | jq '.mirakurunPath | match("^\/\\*") | length')
if [ "$res" -gt 0 ]; then
	echo "$conf" | jq ".mirakurunPath=\"${MIRAKURUN_PATH}\"" >| config.json
fi

if [ ! -s rules.json ]; then
	echo [] > rules.json
fi

rm -f /var/run/chinachu-operator.pid > /dev/null 2>&1
rm -f /var/run/chinachu-wui.pid > /dev/null 2>&1

/etc/init.d/chinachu-operator start
/etc/init.d/chinachu-wui start

tail -f /dev/null
