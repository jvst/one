
echo $0
valgrind --trace-children=yes --trace-children-skip=$SKIP_PROC --leak-check=yes \
    --xml=yes --xml-file=errorMsg.xml --log-file=monitorMsg.log $0
