#!/bin/bash

# CURL BASED
# REQUIRES FILE NAME AS ARGUMENT


# HTTP Proxy Server's Port Number
#port=$2

# We are trying to reach this url via the given HTTP Proxy Server
url="https://ifconfig.co/json"

# Timeout time (in seconds)
timeout=1


while read line
    do
    #echo $line

    # HTTP Proxy Server's IP Address (or URL)
    proxy_server=$line

    # We're fetching the return code and assigning it to the $result variable
    #result=`HEAD -d -p http://$proxy_server:$port -t $timeout $url`
    #result=`HEAD -d -p http://$proxy_server -t $timeout $url`
    result=`curl -I -s -x $proxy_server --connect-timeout $timeout $url | head -n 1  | cut -d/ -f1`
    #echo $result

    # If the return code is 200, we've reached to $url successfully
    if [ "$result" = "HTTP" ]; then
        echo "$proxy_server :: OK (proxy works)"

    # Otherwise, we've got a problem (either the HTTP Proxy Server does not work
    # or the request timed out)

    else
        echo "$proxy_server :: ERR (proxy does not work or request timed out)"
    fi

done <$1

