lf="/root/serials.log"
echo "" > ${lf}

for i in `sg_scan -i |sed -e ':a;N;$!ba;s/\n\s/,/g' |egrep -v 'SanDisk|P420' |cut -d: -f1`;
do
echo "--------->" >> ${lf}
echo "Serial number for device ${i} is:" >> ${lf}
smartctl -a ${i} |grep Serial >> ${lf}
echo "" >> ${lf}
echo "<---------" >> ${lf}
done
