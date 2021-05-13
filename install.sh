yum install -y sg3_utils smartmontools terminator dialog

mkdir -p /root/.config && chmod 700 /root/.config
cp -R /root/sg3/terminator /root/.config/

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl enable sshd
systemctl start sshd
#terminator --layout=sg3 --profile=sg3 --config=/root/.config/terminator/config
