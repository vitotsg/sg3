
for i in `sg_scan -i |sed -e ':a;N;$!ba;s/\n\s/,/g' |egrep -v 'SanDisk|P420' |cut -d: -f1`; do
dn=`echo ${i} |cut -d/ -f3`
echo "Formatting ${i}" > format_${dn}.log
snumber=`smartctl -a ${i} |grep Serial`
echo " ${i} has ${snumber} " >> format_${dn}.log
echo "" >> format_${dn}.log
nohup /usr/bin/sg_format --format --size=512 ${i}  >> format_${dn}.log &
done
