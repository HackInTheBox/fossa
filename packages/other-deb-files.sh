# Download additional 3rd party deb files and install

#########################################################
# Copy and paste deb files to download and install HERE
# Add each URL on a new line
#########################################################
dlfiles=(
   # google chrome x64 for ubuntu/debian
   https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
)

#########################################################
# Script below will download and install above files
#########################################################

DOWNLO="$HOME/Downloads"
mkdir -p "$DOWNLO"
cd "$DOWNLO"

# Download each file in the list to the location listed in $DOWNLO
for item in "${dlfiles[@]}"; do
   echo "Retrieving ${item}..."
   #if item file name already exists, remove old file.
   if [[ -f "$(basename ${item})" ]]; then
      rm -f "$(basename ${item})"
   fi
   wget -nv "$item"
done

# Install each of the downloaded files
for item in "${dlfiles[@]}"; do
   echo "Installing $DOWNLO"/"$(basename ${item})"
   sudo apt-get -y install "$DOWNLO"/"$(basename ${item})"
done

