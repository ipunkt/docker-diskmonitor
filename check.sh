#!/bin/sh

if [ ! -z "${ENVIRONMENT}" ] ; then
	ENVIRONMENT="${ENVIRONMENT}/"
fi
SLEEP="${SLEEP:-5m}"
THRESHOLD="${THRESHOLD:-90}"
HOSTFILE="${HOSTFILE:-/etc/hostname}"
HOSTNAME="${ENVIRONMENT}$(cat $HOSTFILE)"
IS_WARNING="false"

while true ; do
	PERCENT=$(df / --output=pcent | tail -1 | tr -d %)

	if [ "${PERCENT}" -ge "100" ] ; then
		if [ "${FULL_WARNING}" != "true" ] ; then
			MESSAGE="disk on ${HOSTNAME} is ${PERCENT}% -> FULL"
			echo ${MESSAGE}
			slack-message -error "${MESSAGE}"
		fi
		FULL_WARNING="true"
		PERCENT_WARNING="false"
	elif [ "${PERCENT}" -ge "${THRESHOLD}" ] ; then

		if [ "${PERCENT_WARNING}" != "true" ] ; then
			MESSAGE="Current disk percent on ${HOSTNAME} is ${PERCENT}% and thus over the threshold of ${THRESHOLD}%"
			echo ${MESSAGE}
			slack-message -warning "${MESSAGE}"
		fi
		PERCENT_WARNING="true"
	else
		if [ "${PERCENT_WARNING}" = "true" ] ; then
			MESSAGE="Current disk percent on ${HOSTNAME} fell bellow ${THRESHOLD}%"
			echo ${MESSAGE}
			slack-message -ok "${MESSAGE}"
		fi
		FULL_WARNING="false"
		PERCENT_WARNING="false"
	fi

	sleep "${SLEEP}"
done
