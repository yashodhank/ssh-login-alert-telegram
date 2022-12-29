#!/usr/bin/env bash

# Import credentials form config file
. /opt/ssh-login-alert-telegram/credentials.config
for i in "${USERID[@]}"
do
URL="https://api.telegram.org/bot${KEY}/sendMessage"
DATE="$(date "+%d %b %Y %H:%M")"

if [ -n "$SSH_CLIENT" ]; then
        CLIENT_IP=$(echo $SSH_CLIENT | awk '{print $1}')

        SRV_HOSTNAME=$(hostname -f)
        SRV_IP=$(hostname -I | awk '{print $1}')

        IPINFO="https://ipapi.co/?q=${CLIENT_IP}"
        IPINFO2="https://ipregistry.co/${CLIENT_IP}"
        WHOIS="http://whoissoft.com/${CLIENT_IP}"

                IPAPI_OUT=$(curl -s https://ipapi.co/${CLIENT_IP}/json/)

                IPCITY=$(echo $IPAPI_OUT | jq -r .city)
                IPREGION=$(echo $IPAPI_OUT | jq -r .region)
                IPCOUNTRY=$(echo $IPAPI_OUT | jq -r .country_name)
                IPORG=$(echo $IPAPI_OUT | jq -r .org)
                IPASN=$(echo $IPAPI_OUT | jq -r .asn)

        TEXT="Someone logged in via SSH
        Host: *${SRV_HOSTNAME}* (*${SRV_IP}*)
        User: ${USER}
        From: *${CLIENT_IP}*
        Date: ${DATE}
                *IP Info:*
                ${CLIENT_IP}
                ASN: ${IPASN}
                City: ${IPCITY}
                Region: ${IPREGION}
                Country: ${IPCOUNTRY}
                Orgnization: ${IPORG}
        _More informations:_
        [${IPINFO}](${IPINFO})
        [${IPINFO2}](${IPINFO2})
        Whois: [${WHOIS}](${WHOIS})"

        curl -s --max-time 10 --retry 3 --retry-delay 2 --retry-max-time 10 -d "chat_id=$i&text=${TEXT}&disable_web_page_preview=true&parse_mode=markdown&protect_content=true" $URL > /dev/null
fi
done
