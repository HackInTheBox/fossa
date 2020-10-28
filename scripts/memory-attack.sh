   # protect against shared memory attacks
   echo "Configuring security ..."
   echo "Line added to /etc/fstab ..." >> "$LOGFIL"
   echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" | sudo tee -a /etc/fstab >> "$LOGFIL"
   cd "$GITLOC"
