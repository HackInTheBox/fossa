   # set resolution for current user
   if [[ -f "$GITLOC"/resources/monitors.xml ]]; then
      cp "$GITLOC"/resources/monitors.xml "$HOME"/.config/monitors.xml
      echo "Changing monitor resolution settings ... " | tee -a "$LOGFIL"
      echo "Copying $GITLOC/resources/monitors.xml to $HOME/.config/monitors.xml ... " | tee -a "$LOGFIL"
      cat "$GITLOC"/resources/monitors.xml >> "$LOGFIL"
   fi

