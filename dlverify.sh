
for i in `sg_scan -i |sed -e ':a;N;$!ba;s/\n\s/,/g' |egrep -v 'SanDisk|P420' |cut -d: -f1`; do

dn=`echo ${i} |cut -d/ -f3`
echo "Verifying ${i}" > verify_${dn}.log
nohup /usr/bin/sg_verify --count=1172123568 -v ${i}  >> verify_${dn}.log &
done
