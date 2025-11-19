#!/bin/bash


# check if a url argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <shortened_url>"
    echo "eg: $0 http://bit.ly/4o25uIB"
    exit 1
fi

SHORT_URL="$1"
FINAL_URL=$(curl -L  -X GET -s -o /dev/null -w "%{url_effective}\n" "$SHORT_URL")

echo "$FINAL_URL"