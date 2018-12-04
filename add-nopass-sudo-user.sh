USERNAME=$1

cat <<EOF
adduser --disabled-login --gecos '' ${USERNAME} && \\
usermod -G sudo ${USERNAME}

echo "Defaults:${USERNAME} !requiretty" >> /etc/sudoers.d/${USERNAME} && \\
echo "${USERNAME} ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/${USERNAME} && \\
chmod 440 /etc/sudoers.d/${USERNAME}
EOF
