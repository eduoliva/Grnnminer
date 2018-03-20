#!/bin/bash

mkdir -p /home/developer
chown ${uid}:${gid} -R /home/developer

echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd
echo "developer:x:${uid}:" >> /etc/group

echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer
chmod 0440 /etc/sudoers.d/developer

