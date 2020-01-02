#!/bin/sh
### ### ### ASS // ### ### ###

EXCLUDE="/opt/zabbix/smartos_vminfo_vm.exclude"

if [ -s "$EXCLUDE" ]
then
   #// remove empty lines
   awk 'NF' "$EXCLUDE" > /tmp/smartos_vminfo_vm_exclude_1
   mv /tmp/smartos_vminfo_vm_exclude_1 "$EXCLUDE"
   #// special run
   #/usr/sbin/vminfo vms | /usr/xpg4/bin/grep -v -f "$EXCLUDE" | /usr/bin/egrep '"state":' | /usr/bin/awk '{print $2}' | /usr/bin/sed 's/"//' | /usr/bin/sed 's/",//' | /usr/bin/sort -r | /usr/bin/head -n1
   #// as root
   /usr/sbin/vmadm list -o uuid,state | /usr/xpg4/bin/egrep -v "UUID" | /usr/xpg4/bin/egrep -v -f "$EXCLUDE" | /usr/bin/awk '{print $2}' | /usr/bin/sort -r | /usr/bin/head -n1
else
   #// normal run
   #/usr/sbin/vminfo vms | /usr/bin/egrep '"state":' | /usr/bin/awk '{print $2}' | /usr/bin/sed 's/"//' | /usr/bin/sed 's/",//' | /usr/bin/sort -r | /usr/bin/head -n1
   #// as root
   /usr/sbin/vmadm list -o uuid,state | /usr/xpg4/bin/egrep -v "UUID" | /usr/bin/awk '{print $2}' | /usr/bin/sort -r | /usr/bin/head -n1
fi

### ### ### // ASS ### ### ###
# EOF
