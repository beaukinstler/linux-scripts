#!/bin/sh

# Backup
#
# This script backs up all server data to tape.


# Delete old mysql dumps
#rm -f -r /backup/mysql
mkdir /backup/ > /dev/null 2>&1

# Dump all mysql databases
#mysqldump --add-drop-table -A --user=root --password=xxxx > /backup/mysql/databases.sql

# set backup drive 
DRIVE='/dev/sdc1'

# Initialize the tape drive
if /bin/mt -f $DRIVE tell > /dev/null 2>&1
then
    # Some drives require zeroing the data before
    # they can be overwritten.
    /bin/mt -f $DRIVE #rewind > /dev/null 2>&1
    /bin/dd if=/dev/zero of=DRIVE bs=32k count=1 > /dev/null 2>&1
    #/bin/mt -f $DRIVE rewind > /dev/null 2>&1
else
    echo "Backup aborted: No backup drive loaded"
    exit 1
fi

# Do backup
/bin/tar --create --verbose --preserve --ignore-failed-read --file=$DRIVE  / > /backup/filelist.txt

# Add completion date to filelist
echo "Backup complete on " `date` >> /backup/filelist.txt

#/bin/mt -f $DRIVE rewind

/bin/mt -f $DRIVE eject