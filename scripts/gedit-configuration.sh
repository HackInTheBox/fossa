   # load settings for gedit, gnome editor
   # settings file can be created with "dconf dump /org/gnome/gedit/ > ~/gedit.conf
   if [[ -f "$GITLOC/resources/gedit.conf" ]]; then
      dconf load -f /org/gnome/gedit/ < "$GITLOC"/resources/gedit.conf
   fi
