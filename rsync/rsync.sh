#!/usr/bin/env bash
#Dscription: 远程文件上传脚本
echo '-- 远程文件上传脚本 --';

config_file_path="./rsync_config.conf"

if test -e ${config_file_path}
then
    . ${config_file_path}
else
    target_ip=''
fi

# 判断目标ip是否配置
if test -z ${target_ip}
then
    echo -e '请输入目标服务器ip';
    read target_ip
fi

file_path=$1

#判断是否传入参数
if [[ ! ${file_path} ]]
then
    echo -e '请输入要上传的文件路径：\c'
    read file_path
fi

# 判断文件是否存在
if [[ ! -e ${file_path} ]]
then
     echo '文件不存在或者不是普通文件类型！';
     exit 1
else
    echo '即将上传文件：'${file_path};
fi

# 是否指定目标路径 默认 ~/
echo -e "是否指定上传目标路径 默认路径："~/" [y|n]：\c";
read is_up_path

case ${is_up_path} in
    'y'|'yes')
        echo '请输入上传目标路径：';
        read up_path
    ;;
    'n'|'no')
        echo '上传目标路径为: "~/"';
        up_path="~/"
    ;;
    *)
        echo '请输入[y|n] [yes|no]';
        exit 1
esac

echo '开始上传...';

`scp ${file_path} ${target_ip}:${up_path}`

echo '上传完成.';
