#!/bin/sh

SLEEP="${SLEEP:-5m}"
LIMIT="${LIMIT:-90}"
HOSTFILE="${HOSTFILE:-/etc/hostname}"

while true ; do
	PERCENT=$(df / --output=pcent | tail -1 | tr -d %)

	if [ "${PERCENT}" -gt "${LIMIT}" ] ; then
		HOSTNAME=$(cat $HOSTFILE)
		MESSAGE="Current disk percent on ${HOSTNAME} is ${PERCENT}% and thus over the threshold of ${LIMIT}%"
		echo ${MESSAGE}
		./slack-message "${MESSAGE}"
	fi

	sleep "${SLEEP}"
done
