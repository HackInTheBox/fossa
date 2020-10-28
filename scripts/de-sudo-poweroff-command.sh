   # remove the need for certain commands to be password protected 
   # Here I include the commands "reboot" and "poweroff"
   
   echo "Line added to /etc/sudoers ..." >> "$LOGFIL"
   echo "$USER ALL=(ALL) NOPASSWD: /usr/sbin/reboot,/usr/sbin/poweroff" | sudo tee -a /etc/sudoers >> "$LOGFIL"

