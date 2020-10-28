# Download and install Google Chrome
chromeinstall() {
   # Prep
   cd "$DOWNLO"
   chromeurl="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

   # Download 
   if [ -f ./"$(basename $chromeurl)" ]; then
      rm ./"$(basename $chromeurl)"
   fi
   wget -nv "$chromeurl"

   # Install
   sudo apt-get -y install ./"$(basename $chromeurl)"
   if [ $? -eq 0 ]; then
      # If installation successful, add Chrome to the favorites bar in gnome
      if [ -f "$FAVFILE" ]; then
         iconlabel=", 'google-chrome.desktop']"
         sed -E -i "s/.$/$iconlabel/" "$FAVFILE"
      fi
   else
      echo "Google Chrome failed. Please try installing manually"
   fi
}
chromeinstall | tee -a "$LOGFIL"
