USERNAME=$1

cat <<EOF
RUN adduser --disabled-login --gecos '' ${USERNAME} && \\
           usermod -G sudo ${USERNAME}

RUN echo "Defaults:${USERNAME} !requiretty" >> /etc/sudoers.d/${USERNAME} && \\
           echo "${USERNAME} ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/${USERNAME} && \\
           chmod 440 /etc/sudoers.d/${USERNAME}
EOF
