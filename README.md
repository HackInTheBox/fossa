fossa
Init Script for VM stuff on Ubuntu Desktop 20.x

NOTE:  THIS IS EXPERIMENTAL
USE AT YOUR OWN RISK
THIS IS DESIGNED TO BE USED ON ENTIRELY DISPOSABLE VIRTUAL MACHINES
MAY COMPLETELY DESTORY YOUR COMPUTER.  YOU HAVE BEEN WARNED
Copy/paste/run the following function to prep the machine for install
Start copying here ++++++++++++



makeready() {
   # Install git
   sudo apt -y install git   
   # Create a directory in the home folder for git repositories called 'git'
   mkdir -p /home/$USER/git && cd /home/$USER/git
   # Download the files from my repository
   git clone "https://github.com/HackInTheBox/fossa"
   # Run the install script that was downloaded
   bash ./fossa/install.sh
}



Stop copying here ++++++++++++++
Paste that into the terminal and press <enter>
Type "makeready" (without the quotes) as a terminal command and press <enter>
Enter admin password when prompted
