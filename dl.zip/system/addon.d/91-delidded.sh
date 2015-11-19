#!/sbin/sh
# 
# /system/addon.d/91-delidded.sh
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
etc/audio_policy.conf
EOF
}

case "$1" in
  backup)
    echo "STARTING BACKUP"
	
    list_files | while read FILE DUMMY; do
      echo backup_file $S/"$FILE"
      backup_file $S/"$FILE"
    done
    ls -al /tmp
	
    echo "ENDING TO BACKUP"
  ;;
  restore)
    echo "STARTING TO RESTORE"
	
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
      echo $S/$FILE $( ls -alZ $S/$FILE )
    done
	
    echo "ENDING TO RESTORE"
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
	echo "STARTING PRE-RESTORE"
	
	# Remove NFC service, which doesn't work on N900T and drains battery
	mv /system/app/NfcNci/NfcNci.apk /system/app/NfcNci/NfcNci.apk.bak
	
	echo "DONE PRE-RESTORE"
  ;;
  post-restore)
	echo "STARTING POST-RESTORE"

	chmod 644 /system/etc/audio_policy.conf
	chown root:root /system/etc/audio_policy.conf

	#chcon u:object_r:zygote_exec:s0 /system/bin/app_process32_xposed

	echo "DONE POST-RESTORE"
  ;;
esac