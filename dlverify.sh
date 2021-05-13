#!/bin/bash

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="SAS Verify"
MENU="     Choose disk to verify:"

OPTIONS=(1 "600GB SAS disk"
         2 "2TB SAS disk"
         3 "3TB SAS disk")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "600GB SAS disk chosen"  
            export cn_="1172123568"
            echo "Count number is ${cn_}"
            ;;
        2)
            echo "2TB SAS disk chosen"
            export cn_="5860533168"
            echo "Count number is ${cn_}"
            ;;
        3)
            echo "3TB SAS disk chosen"
            export cn_="5860533168"
            echo "Count number is ${cn_}"
            ;;
esac

for i in `sg_scan -i |sed -e ':a;N;$!ba;s/\n\s/,/g' |egrep -v 'SanDisk|P420' |cut -d: -f1`; do

dn=`echo ${i} |cut -d/ -f3`
echo "Verifying ${i}" > verify_${dn}.log
echo "" >> verify_${dn}.log
snumber=`smartctl -a ${i} |grep Serial`
echo " ${i} has ${snumber} " >> verify_${dn}.log
echo "" > verify_${dn}.log
echo "The following command will be executed:" >> verify_${dn}.log
echo "nohup /usr/bin/sg_verify --count=${cn_} -v ${i}  >> verify_${dn}.log &" >> verify_${dn}.log
nohup /usr/bin/sg_verify --count=${cn_} -v ${i}  >> verify_${dn}.log &
done
