#!/bin/sh

if ! grep "^#!" $1 &>/dev/null;

then
cat >> $1 << EOF
#!/bin/sh
#Author: AlexLiu
#Date & Time: `date +"%F %T"`
#Description:
EOF
fi


vim +5 $1
