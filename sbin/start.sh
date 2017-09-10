#跳过不需要检测的进程
SKIP_PROC=Boot*,BankComm*

if [ x$1 != x ]
then
    if [ $1 = "-v" ] 
    then
        cd ../bin
        ./Boot -v
    fi
else
    cd ../bin
    ./LogAgent ../conf/LogAgent.ini
    ./Boot
fi

MONITOR=$1


if [ z$MONITOR == "zMonitor" ]
then
    cd ../bin
    valgrind --trace-children=yes --trace-children-skip=$SKIP_PROC --leak-check=yes \
    --xml=yes --xml-file=errorMsg.xml --log-file=monitorMsg.log ./Boot
fi
