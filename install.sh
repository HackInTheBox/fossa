#!/bin/bash
# install.sh
# https://www.github.com/hackinthebox/fossa.git

# This app sets up a machine for use after the very very inital installation.
# A few commands you need to run first... refer to the README.md file to run those.


installscript() {

   LOGFIL=$HOME/.fossa-git.log
   GITLOC=/home/$USER/git/fossa
   DOWNLO=/home/$USER/Downloads  

   if [[ ! -f $LOGFIL ]]; then
      echo "installed" > $LOGFIL
   else
      echo "Script has already been run.  Running again WILL CAUSE PROBLEMS.  Exiting"
      exit
   fi


   #secure
   sudo ufw enable
   
   # change the hostname
   echo "**Enter only lowercase letters. No spaces. One shot. No re-do's.**"
   read -p "Enter a new hostname for this machine: " NEWNAME
   echo "Setting hostname to $NEWNAME ..." | tee -a $LOGFIL
   sudo hostname $NEWNAME
   sudo hostnamectl set-hostname $NEWNAME
   # change /etc/hosts
      # get the gateway IP address from router
      echo "/etc/hosts file before name change ..." >> $LOGFIL
      sudo cat /etc/hosts >> $LOGFIL
      GATEWY=$(ip route | grep -v tun | grep default | cut -d " " -f 3)
      # resolve the gateway IP into a top-level-domain so a FQDN can be written next
      LANTLD=$(nslookup $GATEWY | grep 'name =' | sed 's/.*name\s\=\s[a-zA-Z0-9\-_]*\.//g' | sed 's/\.$//g')
   sudo sed -i "s/127.0.1.1\t.*/127.0.1.1\t$NEWNAME\.$LANTLD\ $NEWNAME/" /etc/hosts
   sudo sed -i "s/127.0.0.1\t.*/127.0.0.1\tlocalhost\.$LANTLD\ localhost/" /etc/hosts
   echo "/etc hosts AFTER hostname change ..." >> $LOGFIL
   sudo cat /etc/hosts >> $LOGFIL

   # check for lock on dpkg
   checkpkg() {
   sudo apt-get check >/dev/null 2>&1
   if [ "$?" -ne 0 ]; then
      echo "Waiting for background updates to complete. Delaying 2 minutes..." | tee -a $LOGFIL
      sleep 120
      echo "Continuing with install ..."
   fi 
   }
   checkpkg

   # update
   echo "Updating system ..."
   sudo apt-get -y update >> $LOGFIL && sudo apt-get -y dist-upgrade >> $LOGFIL
   sudo apt -y autoremove
   sudo snap refresh

   # install qemu-guest-agent for vitural machines
   sudo apt-get -y install qemu-guest-agent
   sudo systemctl start qemu-guest-agent | tee -a $LOGFIL

   # download and install 'NoMachine"
   echo "Installing NoMachine ..."
   mkdir -p $DOWNLO
   cd $DOWNLO
   wget -nv https://download.nomachine.com/download/6.11/Linux/nomachine_6.11.2_1_amd64.deb
   sudo apt-get -y install /home/$USER/Downloads/nomachine_6.11.2_1_amd64.deb >> $LOGFIL
   sudo ufw allow 4000

   # download and install openssh-server
   echo "Installing OpenSSH Server ..."
   sudo apt-get -y install openssh-server >> $LOGFIL
   sudo ufw allow openssh
   
   echo "Installing additional utilities ..."
   sudo apt-get -y install curl tasksel fail2ban net-tools >> $LOGFIL
   
   # protect against shared memory attacks
   echo "Configuring security ..."
   echo "Line added to /etc/fstab ..." >> $LOGFIL
   echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" | sudo tee -a /etc/fstab >> $LOGFIL
   cd $GITLOC
   # remove the need for certain commands to be password protected 
   echo "Line added to /etc/sudoers ..." >> $LOGFIL
   echo "$USER ALL=(ALL) NOPASSWD: /usr/sbin/reboot,/usr/sbin/poweroff" | sudo tee -a /etc/sudoers >> $LOGFIL
   
   # copy global bashrc commands to /etc/profile.d/
   echo "File /etc/profile.d/global-bashrc.sh added ..." >> $LOGFIL
   cat $GITLOC/global-bashrc.sh >> $LOGFIL
   sudo cp $GITLOC/global-bashrc.sh /etc/profile.d/global-bashrc.sh >> $LOGFIL
   
   # set resolution for current user
   cp $GITLOC/monitors.xml $HOME/.config/monitors.xml
   echo "Changing monitor resolution settings ... " | tee -a $LOGFIL
   echo "Copying $GITLOC/monitors.xml to $HOME/.config/monitors.xml ... " | tee -a $LOGFIL
   cat $GITLOC/monitors.xml >> $LOGFIL
   
   # load settings for gedit, gnome editor
   # settings file can be created with "dconf dump /org/gnome/gedit/ > ~/gedit.conf
   dconf load -f /org/gnome/gedit/ < $GITLOC/gedit.conf
   
   # print a summary
   echo; echo; echo
      ip -br -c a | tee -a $LOGFIL
   echo; echo; echo
      sudo ufw status verbose | tee -a $LOGFIL
   echo; echo; echo
      echo "Type reboot to restart the system and complete installation"
   echo; echo; echo
      sudo dhclient -r
   echo "View logs at $LOGFIL"
   exec bash
}

installscript



