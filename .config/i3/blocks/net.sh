#!/bin/bash 

# Show Wifi Stuff
W_inter=$(ip link | grep "[1-9]: wlp" | cut -d " " -f2 | tr -d ':')
W_con=$(nmcli d | grep "$W_inter" | awk '{print $3}')
W_name=$(nmcli d | grep "$W_inter" | awk '{print $4}')
W_ip=$(ifconfig $W_inter | grep 'netmask' | awk '{print $6}')
W_quality=$(grep $W_inter /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

# Show Ethernet stuff
E_inter=$(ip link | grep "^[1-9]: enp" | cut -d " " -f2 | tr -d :)
E_con=$(nmcli d | grep "$E_inter" | awk '{print $3}')
E_name=$(nmcli d | grep "$E_inter" | awk '{print $4}')
E_ip=$(ifconfig $E_inter | grep 'netmask' | awk '{print $6}')


Wifi () {
if [ "$W_con" = "connected" ];then 
    echo -e " $W_name($W_quality%)"
fi

if [ "$W_con" = "disconnected" ];then 
    echo -e " Off"
fi

if [ "$W_con" = "connecting" ];then 
    echo -e " Connecting"
fi    
}

Ethernet () {
if [ "$E_con" = "connected" ];then 
    echo -e " $E_ip ($E_name)"
fi 
}

case "$1" in 
    "-w" )
        Wifi
    ;;
    "-e" )
        Ethernet
    ;;
    * )
		echo -e " $0 : no Argument \n\t -e : Show Ethernet \n\t -w : Show Wireless"
    ;;
esac 

