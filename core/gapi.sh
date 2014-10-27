#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #"

GAPI_ID=$(docker ps -a | grep piraticz/gapi | awk '{print $1}')

function start_gapi {
    echo "Running GAPI container ..."
    #GAPI_CMD="docker run -t -p 80 -v $DIR/app:/home/app --link=mongodb:db --name gapi -d piraticz/gapi"
    GAPI_CMD="docker run -t -p 8008:8008 -v /home/scippio/sources/gapi/gapi/core/app/:/home/app --name gapi -d piraticz/gapi"
    echo $GAPI_CMD
    GAPI_ID=$($GAPI_CMD)
}

case "$1" in
    start)
        if [ -z "$GAPI_ID" ]; then 
            start_gapi; 
        else 
            docker start $GAPI_ID; 
            IP="$( docker inspect $(docker ps -a | grep "piraticz/gapi:latest" | awk '{ print $1 }') | grep IPAddress | sed -r "s/[\" a-zA-Z:,]//g" )"
            echo "IP: $IP"
        fi
        ;;
    stop)
        if [ -z "$GAPI_ID" ]; then echo "GAPI container no exists, run $0 start"; else docker stop $GAPI_ID; fi
        ;;
    restart)
        if [ -z "$GAPI_ID" ]; then echo "GAPI container no exists, run $0 start"; else docker restart $GAPI_ID; fi
        ;;
    status)
        if [ -z $GAPI_ID ] ; then
            echo "GAPI not running..."
        else
            docker ps -a | grep 'CONTAINER\|piraticz/gapi'
            IP="$( docker inspect $(docker ps -a | grep "piraticz/gapi:latest" | awk '{ print $1 }') | grep IPAddress | sed -r "s/[\" a-zA-Z:,]//g" )"
            echo "IP: $IP"
        fi
        ;;
    *)
        echo -e "\nUsage: $0 {start|stop|restart|status}\n"
        ;;
esac
