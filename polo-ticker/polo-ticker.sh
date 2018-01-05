#!/bin/bash

OLD=0
GREEN='\u001b[32;1m'
RED='\u001b[31;1m'
RESET='\u001b[0m'
function XMRUSDT() {
  #https://monero.stackexchange.com/questions/1356/is-there-a-monero-desktop-ticker
  XMR=$(curl -s "https://poloniex.com/public?command=returnTicker" | egrep -o '"USDT_XMR":{"id":126,"last":"[0-9]+(\.)?([0-9]{0,5})?' | sed 's/"USDT_XMR":{"id":126,"last":"//' | sed 's/"//')
  if (( $(awk 'BEGIN {print ("'$XMR'" > "'$OLD'")}') )); then
    echo -e "∙ XMR: $GREEN $XMR $RESET ∙"
    COLOR='\u001b[32;2m'
  elif (( $(awk 'BEGIN {print ("'$XMR'" == "'$OLD'")}') )); then
    echo -e "∙ XMR: $COLOR $XMR $RESET ∙"
  else 
    echo -e "∙ XMR: $RED $XMR $RESET ∙"
    COLOR='\u001b[31;2m'
  fi
  OLD=$XMR
}

while true ; do XMRUSDT ; sleep 10; done

#curl -s "https://poloniex.com/public?command=returnTicker" | sed 's/},/\n/g' | grep USDT_XMR | cut -c 22-97
#"last":"368.99932416","lowestAsk":"368.99932403","highestBid":"364.96554717"
