#!/bin/sh

# Restore everything
# This script restores all system files from tape.
#
# Initialize the tape drive
if /bin/mt -f "/dev/nst0" tell > /dev/null 2>&1
then
    # Rewind before restore
    /bin/mt -f "/dev/nst0" rewind > /dev/null 2>&1
else
    echo "Restore aborted: No tape loaded"
    exit 1
fi

# Do restore
# The directory order must match the order on the tape.
#
/bin/tar --extract --verbose --preserve --file=/dev/nst0 var etc root usr lib boot bin home sbin backup

# note: in many cases, these directories don't need to be restored:
# initrd opt misc tmp mnt

# Rewind tape when done
/bin/mt -f "/dev/nst0" rewind