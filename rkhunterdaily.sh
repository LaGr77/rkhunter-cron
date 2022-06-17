#!/bin/bash
# written by Ladislav Grulich (LaGr77)
# version 0.2.0
# since 2022-06-17
# licence MIT

#RKHUNTER_LOGFILE="/var/log/rkhunter/rkhunter-$(date +'%w').log"
RKHUNTER_EMAIL="email-1@gmail.com"
RKHUNTER_EMAIL_CC="email-2@gmail.com"
RKHUNTER_EMAIL_FROM="rkHunter@{$HOSTNAME}"

#nice -n0 rkhunter --check --cronjob --report-warnings-only  &>"${RKHUNTER_LOGFILE}";
RKHUNTER_MSG=$(nice -n10 rkhunter --check --cronjob --report-warnings-only)
(
    echo "--------- VERSION SUMMARY ----------"
	rkhunter --versioncheck
    echo ""
    echo "-------------- UPDATE --------------"
    rkhunter --update
    echo ""
    echo "----------- CHECK SYSTEM -----------"
    #cat "${RKHUNTER_LOGFILE}"
    echo $RKHUNTER_MSG
) | mail -s "[RKHUNTER] ${HOSTNAME}" -r "${RKHUNTER_EMAIL_FROM}" "${RKHUNTER_EMAIL}","${RKHUNTER_EMAIL_CC}"


