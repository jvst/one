#!/bin/sh
#echo "before remove message queue:"
#ipcs -q | grep key
#ipcs -q | grep $USER

#查找消息队列的Key
DATABUS_ID=$(cat $APP_HOME/conf/bts.ini | grep -o -E "busID *= *[0-9]+ *$")

#消息队列的Key
MSGID=$(echo $DATABUS_ID | grep -o -E "[0-9]+")

#消息队列的个数
MSG_QUEUE_NUMS=4

i=$MSGID
upper=$((MSGID+MSG_QUEUE_NUMS))
while [ $i -lt $upper ]
do
	ipcrm -Q $i 1>/dev/null 2>&1
	i=$((i+1))
done


#echo "after remove message queue:"
#ipcs -q | grep key
#ipcs -q | grep $USER
