#!/bin/bash
#
# regen_host_keys
#
# (c) 2021 Hackinthebox
# Regenerate host keys from standard SSH installation for security
# Move current host keys to files named ".old"
# !!!!!! Valid only for those formats listed in the variable "cryptype" !!!!!!!
#
#
#
functionregen() {
prefix="/etc/ssh"
cryptype=(
ecdsa
ed25519
rsa
)
for j in "${cryptype[@]}"; do
   keyname="$prefix"/ssh_host_"$j"_key
   if [ -f "$keyname" ]; then
      mv "$keyname" "$keyname".old
   fi
   if [ -f "$keyname".pub ]; then   
      mv "$keyname".pub "$keyname".pub.old
   fi
   ssh-keygen -t "$j" -P '' -f "$prefix"/ssh_host_"$j"_key
done
}
functionregen
