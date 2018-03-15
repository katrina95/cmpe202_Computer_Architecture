#!/bin/bash
echo '0' > /proc/sys/kernel/nmi_watchdog
instructions=1
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
/root/pmu-tools/toplev.py -I 1000 -l3 -x, -o tl-build.csv /root/cmpe202_Computer_Architecture/run.sh -i ${instructions} -t ${thread}
/root/pmu-tools/tl-barplot.py --cpu C0-T0 tl-build.csv -o /root/plot_${instruction}_${thread}.png
