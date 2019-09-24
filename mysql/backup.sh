#!/usr/bin/env bash
#Description: 定时备份mysql数据库脚本

echo '-- 定时备份mysql数据库脚本 --'

mysql_ip='127.0.0.1'
mysql_user='root'
mysql_pwd=''
mysql_dump_path='/usr/local/mysql/bin/'
db_name=''
export_path="/root/backup/"

while [[ $# -ge 1 ]]; do
    cmd=$1
#    shift 1
    case ${cmd} in
         -i|--ip)
            mysql_ip=$2
            shift 2
         ;;
         -u|--user)
            mysql_user=$2
            shift 2
         ;;
         -p|--pwd)
             mysql_pwd=$2
            shift 2
         ;;
         -n|--name)
             db_name=$2
            shift 2
         ;;
         *)
            echo -e "-i --ip：指定数据库ip\n-u --user：指定登录用户\n-p --pwd：输入登录密码\n-n --name：要备份的数据库\n";
            break
    esac
done

# 拼接备份命令
echo -e "备份执行命令：\c"
command="${mysql_dump_path}mysqldump -u${mysql_user} -p${mysql_pwd} ${db_name}"

#echo ${command}
echo "即将开始备份..."

export_file_name=${db_name}"_"`date +%Y-%m-%d_%H:%M:%S`".sql"

echo "备份中..."

`${command}  > ${export_path}${export_file_name} 2>/dev/null`

echo "备份完成 本次导出文件："${export_path}${export_file_name};

