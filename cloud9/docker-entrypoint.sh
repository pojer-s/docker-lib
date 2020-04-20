#!/bin/bash

if [ -z "$WORKDIR" ]; then WORKDIR="/var/project" ; fi
if [ -z "$PORT" ];    then PORT="8181"            ; fi
if [ -z "$LISTEN" ];  then LISTEN="0.0.0.0"       ; fi
if [ -z "$AUTH" ];    then AUTH=":"               ; fi

OPTS="-b -w $WORKDIR --auth $AUTH --listen $LISTEN"

if [ "$1" == "nodejs" ] ; then
    $@ $OPTS
else
    $@
fi
