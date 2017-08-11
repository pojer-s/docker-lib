#!/usr/bin/env bash

for user in $USERS ; do
    login=$(echo $user | cut -d: -f1)
    hash_pass=$(echo $user | cut -d: -f2)
    useradd -s /bin/false --create-home --groups sftponly $login --password $hash_pass
    chown root:root /home/$login
    mkdir /home/$login/data
    chown $login: /home/$login/data
done

cat <<EOF >> /etc/ssh/sshd_config
Match Group sftponly
  ChrootDirectory %h
  ForceCommand internal-sftp
  AllowTcpForwarding no
  PermitTunnel no
  X11Forwarding no
EOF

exec "$@"
