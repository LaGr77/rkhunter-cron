#!/bin/bash
# written by Ladislav Grulich (LaGr77)
# version 0.1.1
# since 2022-01-20
# licence MIT

#First TODO
# nano /etc/rkhunter.conf
# MIRRORS_MODE=1
# MIRRORS_MODE=0
# WEB_CMD=""

# rkhunter -C

# rkhunter --update

# rkhunter --versioncheck

# rkhunter --propupd

# rkhunter --check
# rkhunter --check --sk
# rkhunter --check --report-warnings-only

# nano /etc/rkhunter.conf
# ALLOWHIDDENDIR=/etc/.java

RKHUNTER_LOGFILE="/var/log/rkhunter/rkhunter-$(date +'%w').log"
RKHUNTER_EMAIL="email-1@gmail.com"
RKHUNTER_EMAIL_CC="email-2@gmail.com"
RKHUNTER_EMAIL_FROM="rkHunter@{$HOSTNAME}"

nice -n10 rkhunter --check --report-warnings-only  &>"${RKHUNTER_LOGFILE}";
##--cronjob

(
    echo "--------- VERSION SUMMARY ----------"
	rkhunter --versioncheck
    echo ""
    echo "-------------- UPDATE --------------"
    rkhunter --update
    echo ""
    echo "----------- CHECK SYSTEM -----------"
    cat "${RKHUNTER_LOGFILE}"
) | mail -s "[RKHUNTER] ${HOSTNAME}" -r "${RKHUNTER_EMAIL_FROM}" "${RKHUNTER_EMAIL}","${RKHUNTER_EMAIL_CC}"


