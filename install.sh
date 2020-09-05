#!/bin/bash
# install.sh
# https://www.github.com/hackinthebox/fossa.git

# This app sets up a machine for use after the very very inital installation.
# A few commands you need to run first... refer to the README.md file to run those.


installscript() {
   if [[ ! -f /home/$USER/.fossa.git.txt ]]; then
      echo "installed" > /home/$USER/.fossa.git.txt
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
   #sudo sed -i 's/Name=Xfce Session/Name=Xfce_Session/' /usr/share/xsessions/xfce.desktop
   sudo sed -i "s/127.0.1.1\t.*/127.0.1.1\t$NEWNAME/" /etc/hosts

   # update
   sudo apt -y update && sudo apt -y dist-upgrade
   sudo apt autoremove
   sudo snap refresh

   # download and install 'NoMachine"
   mkdir -p /home/$USER/Downloads
   cd /home/$USER/Downloads
   wget -nv https://download.nomachine.com/download/6.11/Linux/nomachine_6.11.2_1_amd64.deb
   sudo apt install /home/$USER/Downloads/nomachine_6.11.2_1_amd64.deb
   sudo ufw allow 4000

   # download and install openssh-server
   sudo apt -y install openssh-server
   sudo ufw allow openssh
   
   sudo apt -y install curl
   
   # protect against shared memory attacks
   echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" | sudo tee -a /etc/fstab
   
   exec bash
   echo; echo; echo
   echo "Please reboot the system to complete installation (/etc/fstab)"
   
}

installscript


