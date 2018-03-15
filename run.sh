#!/bin/bash
instructions=8
thread=1
while getopts "i:t:" arg
do
case $arg in
	i)
		instructions=$OPTARG
	;;
	t)
		thread=$OPTARG
	;;
        esac
done
[ -e /tmp/fd1 ] || mkfifo /tmp/fd1
exec 3<>/tmp/fd1
rm -rf /tmp/fd1
for ((i=1;i<=$thread;i++))
do
	echo >&3
done

for ((i=1;i<=$instructions;i++))
do
read -u3
{
~/facenet/src/validate_on_lfw.py ~/datasets/lfw/lfw_mtcnnpy_160 ~/models/20170512-110547
echo >&3 
}&
done
wait
exec 3<&-
exec 3>&- 
