lf="/root/serials.log"
echo "" > ${lf}

for i in {1..8}
do
echo "--------->" >> ${lf}
echo "Serial number for device /dev/sg${i} is:" >> ${lf}
smartctl -a /dev/sg${i} |grep Serial >> ${lf}
echo "" >> ${lf}
echo "<---------" >> ${lf}
done
