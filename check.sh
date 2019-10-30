#!/bin/sh

SLEEP="${SLEEP:-5m}"
LIMIT="${LIMIT:-90}"
HOSTFILE="${HOSTFILE:-/etc/hostname}"
HOSTNAME=$(cat $HOSTFILE)

while true ; do
	PERCENT=$(df / --output=pcent | tail -1 | tr -d %)

	if [ "${PERCENT}" -gt "100" ] ; then
		MESSAGE="disk on ${HOSTNAME} is ${PERCENT}% -> FULL"
		slack-message -error "${MESSAGE}"
	elif [ "${PERCENT}" -gt "${LIMIT}" ] ; then
		MESSAGE="Current disk percent on ${HOSTNAME} is ${PERCENT}% and thus over the threshold of ${LIMIT}%"
		echo ${MESSAGE}
		slack-message -warning "${MESSAGE}"
	fi

	sleep "${SLEEP}"
done
