#!/bin/sh
SERVICE_NAME=minsys
AJAVAAPP=/etc/ranmgr/jv/bin/java
PATH_TO_JAR=/etc/ranmgr/minsys/sysdir.jar
PID_PATH_NAME=/etc/ranmgr/fdb.tpm
LOG_BY_Q=/etc/ranmgr/fdb0.tpm

case $1 in
   start)
          echo "Starting $SERVICE_NAME ..."
          if [ ! -f $PID_PATH_NAME ]; then
              nohup $AJAVAAPP -jar $PATH_TO_JAR >> $LOG_BY_Q 2>&1&
              echo $! > $PID_PATH_NAME
              echo "$SERVICE_NAME started ..."
          elif [ -f $PID_PATH_NAME ]; then
              PID=$(cat $PID_PATH_NAME);
              if [ -n "$PID" -a -e /proc/$PID ]; then
                  echo "process exists"
              else
                  rm -rf $PID_PATH_NAME
                  rm -rf $LOG_BY_Q
                  nohup $AJAVAAPP -jar $PATH_TO_JAR >> $LOG_BY_Q 2>&1&
                  echo $! > $PID_PATH_NAME
                  echo "$SERVICE_NAME start refresh..."                   
              fi
          else
              echo "$SERVICE_NAME is already running ..."
          fi
   ;;
   stop)
       if [ -f $PID_PATH_NAME ]; then
           PID=$(cat $PID_PATH_NAME);
           echo "$SERVICE_NAME stoping ..."
           kill $PID;
           kill $(pgrep lsass);
           echo "$SERVICE_NAME stopped ..."
           rm -rf $PID_PATH_NAME
           rm -rf $LOG_BY_Q
       else
           echo "$SERVICE_NAME is not running ..."
       fi
   ;;
   restart)
       if [ -f $PID_PATH_NAME ]; then
           PID=$(cat $PID_PATH_NAME);
           echo "$SERVICE_NAME stopping ...";
           kill $PID;
           kill $(pgrep lsass);
           echo "$SERVICE_NAME stopped ...";
           rm -rf $PID_PATH_NAME
           rm -rf $LOG_BY_Q
           echo "$SERVICE_NAME starting ..."
           nohup $AJAVAAPP -jar $PATH_TO_JAR >> $LOG_BY_Q 2>&1&
                       echo $! > $PID_PATH_NAME
           echo "$SERVICE_NAME started ..."
       else
           echo "$SERVICE_NAME is not running ..."
       fi
   ;;
esac
