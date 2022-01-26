#!/bin/bash
# written by Ladislav Grulich (LaGr77)
# version 0.1.2
# since 2022-01-26
# licence MIT

RKHUNTER_LOGFILE="/var/log/rkhunter/rkhunter-$(date +'%w').log"
RKHUNTER_EMAIL="email-1@gmail.com"
RKHUNTER_EMAIL_CC="email-2@gmail.com"
RKHUNTER_EMAIL_FROM="rkHunter@{$HOSTNAME}"

nice -n0 rkhunter --check --cronjob --report-warnings-only  &>"${RKHUNTER_LOGFILE}";

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


