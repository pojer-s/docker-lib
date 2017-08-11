#!/bin/sh

VERSION="1.3"

EXIM=/usr/sbin/exim

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

FLAG_VERBOSE=FALSE
LEVEL_WARN="10"
LEVEL_CRIT="20"
RESULT=""
EXIT_STATUS=$STATE_OK


###############################################
#
## FUNCTIONS
#

## Print usage
usage() {
	echo " check_eximailqueue $VERSION - Nagios Exim mail queue check script"
	echo ""
	echo " Usage: check_eximailqueue -w <warning queue size> -c <critical queue size> [ -v ] [ -h ]"
	echo ""
	echo "		 -w  Queue size at which a warning is triggered"
	echo "		 -c  Queue size at which a critical is triggered"
	echo "		 -v  Verbose output (ignored for now)"
	echo "		 -h  Show this page"
	echo ""
}

## Process command line options
doopts() {
	if ( `test 0 -lt $#` )
	then
		while getopts w:c:vh myarg "$@"
		do
			case $myarg in
				h|\?)
					usage
					exit;;
				w)
					LEVEL_WARN=$OPTARG;;
				c)
					LEVEL_CRIT=$OPTARG;;
				v)
					FLAG_VERBOSE=TRUE;;
				*)	# Default
					usage
					exit;;
			esac
		done
	fi
}


# Write output and return result
theend() {
	echo $RESULT
	exit $EXIT_STATUS
}


#
## END FUNCTIONS
#

#############################################
#
## MAIN
#


# Handle command line options
doopts $@

# Do the do
OUTPUT=`$EXIM -bpc`
if test -z "$OUTPUT" ; then
	RESULT="Mailqueue WARNING - query returned no output!"
	EXIT_STATUS=$STATE_WARNING
else
	if test "$OUTPUT" -lt "$LEVEL_WARN" ; then
		RESULT="Mailqueue OK - $OUTPUT messages on queue"
		EXIT_STATUS=$STATE_OK
	else
		if test "$OUTPUT" -ge "$LEVEL_CRIT" ; then
			RESULT="Mailqueue CRITICAL - $OUTPUT messages on queue"
			EXIT_STATUS=$STATE_CRITICAL
		else
			if test "$OUTPUT" -ge "$LEVEL_WARN" ; then
				RESULT="Mailqueue WARNING - $OUTPUT messages on queue"
				EXIT_STATUS=$STATE_WARNING
			fi
		fi
	fi
fi

# Quit and return information and exit status
theend
