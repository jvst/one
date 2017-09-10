#!/bin/sh
LogFile=../log/bts.log

Flag=-n

Usage="\n \
./logtool.sh -h 查看帮助\n \
./logtool.sh :查看当前最新日志文件bts.log的ERROR级别日志\n\n \
 -a :表示所有日志文件,不加则表示仅当前最新bts.log\n \
 -c :表示只统计结果行数,不显示匹配行内容\n \
 -f 指定日志文件,不加则默认为最新日志文件bts.log\n\n \
./logtool.sh  -r :删除当前最新日志文件\n \
./logtool.sh -ar :删除所有日志文件\n \
./logtool.sh -s :显示最新日志文件内容bts.log\n\n \
./logtool.sh -t 20160719 :在bts.log中查找指定日期的日志\n \
./logtool.sh -t 15302.. :在bts.log中查找指定时间的日志\n \
./logtool.sh -at 20160718 1530 :在所有日志文件中查找指定日期时间的日志\n \
./logtool.sh -f bts.20160719.*.log -t 1530 :在0719当天所有的日志文件中查找15:30分的日志\n\n \
./logtool.sh -l SYS :在bts.log中查找SYS类型的系统日志\n \
./logtool.sh -l INFO :在bts.log中查找INFO级别的日志\n \
\t 同理 -l 可以配合-f 或 -a, -c参数 查找指定日志 \n\n \
./logtool.sh -p ...... :在bts.log中查找自定义匹配模式的日志\n        \
\t 同理 -p 可以配合-f 或 -a, -c参数 查找指定日志 \n\n \
./logtool.sh -u .... :指定UUID在bts.log中查找日志,UUID可只填一部分\n        \
\t 同理 -u 可以配合-f 或 -a, -c参数 查找指定日志 \n\n "

while getopts "hracsf:l:t:p:u:" arg
do
    case $arg in
        h)
            # 查看帮助
            echo -e $Usage
            exit 0
            ;;
        r)
            # -r 删除日志文件
            rm -r $LogFile
            exit 0
            ;;
        a)
            # -a (all 所有日志文件)
            LogFile=../log/bts.log*
            ;;
        c)
            # -c (count统计匹配行数)
            Flag=-c
            ;;
        s)
            # -s (show 直接显示bts.log文件)
            cat $LogFile 
            exit 0
            ;;
        f)
            # -f filename 指定日志文件
            LogFile=$OPTARG 
            ;;
        t)
            # -t time 指定日期时间
            grep $Flag -E "^[0-9]{4}\s\[$OPTARG|^[0-9]{4}\s\[[0-9]{8}\s$OPTARG" $LogFile --color=auto
            exit 0
            ;;
        l)
            # -l level(查看指定等级的日志)
            grep $Flag -E "\[[USRY]{3}:$OPTARG\]|\[$OPTARG:.{5}\]" $LogFile --color=auto
            exit 0
            ;;
        p)
            # -p pattern(指定匹配模式pattern)
            grep $Flag -E $OPTARG $LogFile
            exit 0
            ;;
        u)
            # -u ****(指定UUID查找, 支持UUID不完整查找)
            grep $Flag -E "\[UUID:.*$OPTARG[^\[]*\]" $LogFile --color=auto
            exit 0 
            ;;
        ?)
            echo "Unknow option, './logtool.sh -h' see help"
            exit 1 
            ;;
    esac
done

#默认查找最新的错误日志
grep $Flag  -E "\[[USRY]{3}:ERROR\]" $LogFile --color=auto 
#每个匹配行末尾再增加换行符
#| awk '{print $0, "\n"}'

