#!/usr/bin/env bash
#************************************************#
# 文件名：DBCHK_ORA_BIGSEGMENTS.sh            #
# 作  者：ycl                            #
# 日  期：2015年 09月24日                        #
# 功  能：查询前一天的alert日志中错误信息     #
# 复核人：                                       #
#************************************************#
#脚本描述
#keys:timestamp|日期|string,message|错误信息|string
#describe:查询前一天的alert日志中错误信息
#threshold:
#stype:list
#version:g.0.1

#参数定义
LANG=en_US.utf8
basepath=$(dirname $0)
tmpfile="/tmp/$0.$$"

#阈值定义
_DEFAULT="WARNING|fail|errs|ORA-|abort|corrupt|bad|not complete"
: ${ERRORLIST:=$_DEFAULT}

#查询log日志位置
#调用sqlplus 库脚本
sqlplus -S "/as sysdba" 1>&2 2>/dev/null <<EOF
 @${basepath}/../sqllib/showparameters.sql $tmpfile
EOF

#output
[ -f $tmpfile ] && (cat $tmpfile ; rm $tmpfile)