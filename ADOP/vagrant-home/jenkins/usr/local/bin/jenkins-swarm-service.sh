#!/bin/bash
SERVICE_NAME=jenkins-swarm-slave
PATH_TO_JAR=/root/vagrant-home/jenkins/swarm-client.jar
args=(-executors 1 -description "Docker Host" -master "http://localhost:80/jenkins/" -username jenkins -password password -name Host -labels host -mode exclusive)
PID_PATH_NAME=/tmp/jenkins-swarm-slave

case $1 in
    start)
        echo "Starting $SERVICE_NAME ..."
        if [ ! -f $PID_PATH_NAME ]; then

            nohup java -jar $PATH_TO_JAR "${args[@]}" >> /var/log/$SERVICE_NAME.log 2>&1 &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is already running ..."
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stoping ..."
            kill $PID;
            echo "$SERVICE_NAME stopped ..."
            rm $PID_PATH_NAME
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            kill $PID;
            echo "$SERVICE_NAME stopped ...";
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..."
            nohup java -jar $PATH_TO_JAR "${args[@]}" >> /var/log/$SERVICE_NAME.log 2>&1 &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
esac