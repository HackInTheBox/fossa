#!/bin/bash
# install.sh
# https://www.github.com/hackinthebox/fossa.git

# This app sets up a machine for use after the very very inital installation.
# A few commands you need to run first... refer to the README.md file to run those.


installscript() {

   LOGFIL=$HOME/.fossa.git.txt
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
   echo "**Enter only lowercase letters! No spaces!**"
   read -p "Enter a new hostname for this machine: " NEWNAME
   sudo hostname $NEWNAME
   sudo hostnamectl set-hostname $NEWNAME
   # change /etc/hosts
      # get the gateway IP address from router
      GATEWY=$(ip route | grep -v tun | grep default | cut -d " " -f 3)
      # resolve the gateway IP into a top-level-domain so a FQDN can be written next
      LANTLD=$(nslookup $GATEWY | grep 'name =' | sed 's/.*name\s\=\s[a-zA-Z0-9\-_]*\.//g' | sed 's/\.$//g')
   sudo sed -i "s/127.0.1.1\t.*/127.0.1.1\t$NEWNAME\.$LANTLD\ $NEWNAME/" /etc/hosts
   sudo sed -i "s/127.0.0.1\t.*/127.0.0.1\tlocalhost\.$LANTLD\ localhost/" /etc/hosts

   # update
   sudo apt-get -y update >> $LOGFIL && sudo apt-get -y dist-upgrade >> $LOGFIL
   sudo apt autoremove
   sudo snap refresh

   # download and install 'NoMachine"
   mkdir -p $DOWNLO
   cd $DOWNLO
   wget -nv https://download.nomachine.com/download/6.11/Linux/nomachine_6.11.2_1_amd64.deb
   sudo apt-get -y install /home/$USER/Downloads/nomachine_6.11.2_1_amd64.deb >> $LOGFIL
   sudo ufw allow 4000

   # download and install openssh-server
   sudo apt-get -y install openssh-server >> $LOGFIL
   sudo ufw allow openssh
   
   sudo apt-get -y install curl >> $LOGFIL
   
   # protect against shared memory attacks
   echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" | sudo tee -a /etc/fstab >> $LOGFIL
   cd $GITLOC
   # remove the need for certain commands to be password protected 
   echo "$USER ALL=NOPASSWD:/usr/sbin/reboot,/usr/sbin/poweroff" | sudo tee -a /etc/sudoers >> $LOGFIL
   
   # print a summary
   echo; echo; echo
      ip -br -c a
   echo; echo; echo
      sudo ufw status verbose
   echo; echo; echo
      echo "Type reboot to restart the system and complete installation"
   echo; echo; echo
      sudo dhclient -r
      exec bash
}

installscript


