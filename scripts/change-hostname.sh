   # change the hostname
   echo "**Enter only lowercase letters. No spaces. One shot. No re-do's.**"
   read -p "Enter a new hostname for this machine: " NEWNAME
   echo "Setting hostname to $NEWNAME ..." | tee -a "$LOGFIL"
   sudo hostname "$NEWNAME"
   sudo hostnamectl set-hostname "$NEWNAME"
   # change /etc/hosts
      # get the gateway IP address from router
      echo "/etc/hosts file before name change ..." >> "$LOGFIL"
      sudo cat /etc/hosts >> "$LOGFIL"
      GATEWY=$(ip route | grep -v tun | grep default | cut -d " " -f 3)
      # resolve the gateway IP into a top-level-domain so a FQDN can be written next
      LANTLD=$(nslookup "$GATEWY" | grep 'name =' | sed 's/.*name\s\=\s[a-zA-Z0-9\-_]*\.//g' | sed 's/\.$//g')
   sudo sed -i "s/127.0.1.1\t.*/127.0.1.1\t$NEWNAME\.$LANTLD\ $NEWNAME/" /etc/hosts
   sudo sed -i "s/127.0.0.1\t.*/127.0.0.1\tlocalhost\.$LANTLD\ localhost/" /etc/hosts
   echo "/etc hosts AFTER hostname change ..." >> "$LOGFIL"
   sudo cat /etc/hosts >> "$LOGFIL"
   sudo dhclient -r
