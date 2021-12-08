#!/bin/bash

set -e

if [ -n "$UPSTREAM_SERVER" ] ; then
    if [ -z "$TIMEOUT" ] ; then
        echo '$TIMEOUT not set'
        exit 1
    fi

    printf "\n### Waiting for %s...\n" "$UPSTREAM_SERVER"

    counter="$TIMEOUT"
    i=1

    while [ "$i" -le "$counter" ] && ! ping -c1 "$UPSTREAM_SERVER" >/dev/null 2>&1
    do
        sleep 1 ;
        i=$(( i+1 ))
    done

    if ping -c1 "$UPSTREAM_SERVER" >/dev/null 2>&1 ; then
        printf "\n### %s responded\n" "$UPSTREAM_SERVER"
        exec "$@"
    else
        printf "\n### %s not responding, exiting...\n" "$UPSTREAM_SERVER"
        exit 1
    fi
else
    exec "$@"
fi