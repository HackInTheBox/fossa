# download and install 'NoMachine"
   
nomachi() {
   cd "$DOWNLO"
   
   # Download Nomachine HTML download page to temp file
   wget -nv -O ./nomachine.temp "https://www.nomachine.com/download/download&id=2"
   
   # Scrape the latest version and actual download link
   # As long as the above download page stays the same, this code will automatically get the latest version
   nomachineurl="$(cat ./nomachine.temp | grep -E -o 'https(.*)deb')"
   
   # Remove temp html file
   rm ./nomachine.temp
   
   # Download latest version
   if [ -f ./"$(basename $nomachineurl)" ]; then
      rm ./"$(basename $nomachineurl)"
   fi
   wget -nv "$nomachineurl"
   
   # Install
   sudo apt-get -y install ./"$(basename $nomachineurl)"
   if [ $? -eq 0 ]; then
      # Allow incoming connections on firewall
      sudo ufw allow 4000
      # If installation successful, add NoMachine to the favorites bar in gnome
      if [ -f "$FAVFILE" ]; then
         iconlabel=", 'NoMachine-base.desktop']"
         sed -E -i "s/.$/$iconlabel/" "$FAVFILE"
      fi
   else
      echo "NoMachine Installation failed. Please try installing manually"
   fi
   
}
nomachi | tee -a "$LOGFIL"
