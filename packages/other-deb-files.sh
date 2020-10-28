# Download additional 3rd party deb files and install

#########################################################
# Copy and paste deb files to download and install HERE
# Add each URL on a new line
#########################################################
dlfiles=(
   # No files currently listed
)

#########################################################
# Script below will download and install above files
#########################################################
otherdebfiles() {

if [ ${#dlfiles[@]} -gt 0 ]; then

   cd "$DOWNLO"

   # Download each file in the list to the location listed in $DOWNLO
   for item in "${dlfiles[@]}"; do
      echo "Retrieving $item..."
      #if item file name already exists, remove old file.
      if [ -f ./"$(basename $item)" ]; then
         rm -f ./"$(basename $item)"
      fi
      wget -nv "$item"
   done

   # Install each of the downloaded files
   for item in "${dlfiles[@]}"; do
      echo "Installing ./$(basename $item)"
      sudo apt-get -y install ./"$(basename $item)"
   done
else
   echo "No files listed in other-deb-files.sh.  Moving on..."
fi 
}
otherdebfiles | tee -a "$LOGFIL"


