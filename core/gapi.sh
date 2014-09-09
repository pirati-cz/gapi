#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #"

MONGO_ID=$(docker ps -a | grep dockerfile/mongodb | awk '{print $1}')
GAPI_ID=$(docker ps -a | grep piraticz/gapi | awk '{print $1}')

function start_mongo {
    echo "Running MongoDB container ..."
    MONGO_CMD="docker run -t -v $DIR/data:/data --name=mongodb -d dockerfile/mongodb mongod --smallfiles"
    echo $MONGO_CMD
    MONGO_ID=$($MONGO_CMD)
}

function start_gapi {
    if [ -z "$MONGO_ID" ]; then
        start_mongo
    fi
    echo "Running GAPI container ..."
    GAPI_CMD="docker run -t -p 80 -v $DIR/app:/home/app --link=mongodb:db --name gapi -d piraticz/gapi"
    echo $GAPI_CMD
    GAPI_ID=$($GAPI_CMD)
}

case "$1" in
    start)
        if [ -z "$GAPI_ID" ]; then start_gapi; else docker start $GAPI_ID; fi
        ;;
    stop)
        if [ -z "$GAPI_ID" ]; then echo "GAPI container no exists, run $0 start"; else docker stop $GAPI_ID; fi
        ;;
    restart)
        if [ -z "$GAPI_ID" ]; then echo "GAPI container no exists, run $0 start"; else docker restart $GAPI_ID; fi
        ;;
    status)
        docker ps -a | grep 'CONTAINER\|piraticz/gapi'
        ;;
    *)
        echo -e "\nUsage: $0 {start|stop|restart|status}\n"
        ;;
esac
