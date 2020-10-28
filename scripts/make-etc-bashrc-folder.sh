# ADD A DIRECTORY called /etc/bash.bashrc.d 
# AND initialize it's contents when /etc/bash.bashrc is run

if [ ! -d /etc/bash.bashrc.d ]; then
   unset i
   sudo mkdir -p /etc/bash.bashrc.d
   sudo chmod 755 /etc/bash.bashrc.d
codeblob='

# Run scripts found in /etc/bash.bashrc.d 
if [ -d /etc/bash.bashrc.d ]; then
  for i in /etc/bash.bashrc.d/*.bashrc; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
'
   if [ -f /etc/bash.bashrc ]; then
      echo "$codeblob" | sudo tee -a /etc/bash.bashrc
   fi
fi
# copy global bashrc commands to /etc/bash.bashrc.d/
   if [[ -d "$GITLOC"/resources ]]; then
      if [[ -d "/etc/bash.bashrc.d" ]]; then  
         for script in "$GITLOC"/resources/*.bashrc; do
            sudo cp "$script" /etc/bash.bashrc.d
         done
      fi 
   fi
