#!/bin/bash
# install.sh
# https://www.github.com/hackinthebox/fossa.git

# This app sets up a machine for use after the very very inital installation.
# A few commands you need to run first... refer to the README.md file to run those.


installscript() {

   declare -g LOGFIL="$HOME/.fossa-git.log"
   declare -g GITLOC="/home/$USER/git/fossa"
   declare -g DOWNLO="/home/$USER/Downloads"

   if [[ ! -f "$LOGFIL" ]]; then
      echo "installing..." > "$LOGFIL"
   else
      echo "Script has already been run.  Running again WILL CAUSE PROBLEMS.  Exiting"
      exit
   fi


   #enable firewall
   sudo ufw enable
   
   # check for lock on dpkg
   safepkg() {
      unset errck
      errck=0
      while [ $errck -ne 1 ]; do
         sudo apt-get check >/dev/null 2>&1
         if [ "$?" -eq 0 ]; then
            errck=1
            echo "Continuing with installation..."
         else
            echo "Package manager busy.  Trying again in 30 seconds."
            sleep 30
         fi
      done
   }
   safepkg

   # update
   echo "Updating system ..."
   sudo apt-get -y update >> "$LOGFIL" && sudo apt-get -y dist-upgrade >> "$LOGFIL"
   sudo apt -y autoremove
   sudo snap refresh

   # INSTALL PACKAGES
   runinstalls() {
      if [ -d "$GITLOC"/packages ]; then
         for installitem in "$GITLOC/packages/*.sh"; do
            source "$installitem"
         done
      fi
   }
   runinstalls | tee -a "$LOGFIL"

   # RUN EXTRA SCRIPTS
   runxtrascripts() {
      if [ -d "$GITLOC"/scripts ]; then
         for scriptitem in "$GITLOC"/scripts/*.sh; do
            source "$scriptitem"
         done
      fi
   }
   runxtrascripts | tee -a "$LOGFIL"

   # print a summary
   clear
      ip -br a | tee -a "$LOGFIL"
   echo
      sudo ufw status verbose | tee -a "$LOGFIL"
   echo
   echo '!!!! Type reboot to restart the system and complete installation !!!!'
   echo "View logs at $LOGFIL"
   exec bash
}

installscript
