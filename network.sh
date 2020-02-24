#!/usr/bin/bash
clear
COLUMNS=12
newline=$'\n'
function list_interfaces(){
    echo "${newline}--------------All Network Interfaces--------------${newline}"
    ls /sys/class/net
}
function more_info(){
    echo $'\n'
    echo "${newline}--------------- $1 Interface Info--------------${newline}"
    ifconfig $1
}
function is_interface_exist(){
    local interface="/etc/sysconfig/network-scripts/ifcfg-$1"
    [[ -f "$interface" ]] && return 0 || return 1
}
function automatic_settings(){
echo "DEVICE=$1
BOOTPROTO=dhcp
ONBOOT=yes"> /etc/sysconfig/network-scripts/ifcfg-$1
systemctl restart network
echo "=========== Automatic Settings Done Successful for $1 =========="
}
function manual_settings(){
read -p "Enter IP Address : " IP
read -p "Enter Subnet mask  : " netmask
read -p "Default gateway  : " gateway
read -p "Primary DNS : " dns1
read -p "Secondary DNS : " dns2
read -p "Are you sure you want to update these settings ? [y/n] : " answer
case $answer in 
[yY] )
    echo "DEVICE=$1
    IPADDR=$IP
    NETMASK=$netmask
    GATEWAY=$gateway
    DNS1=$dns1
    DNS2=$dns2
    ONBOOT=yes"> /etc/sysconfig/network-scripts/ifcfg-$1
    systemctl restart network
    echo "=========== Manual Settings Done Successful for $1 =========="
    ;;
[nN] )
    echo "=========== No updates were done for $1 =========="
    ;;
esac

}
while true
echo  $'\n------------------NETWORK-------------------'
PS3="Select an option : "
do
select option in "List All Network Interfaces Names" "Display more info for specific interface" "Modify Netowrk Settings" "Back"
do
    case $option in
    "List All Network Interfaces Names" )
        list_interfaces 
        break
        ;;
    "Display more info for specific interface" )
        read -p "Enter Interface Name: " interface_name
        if ( is_interface_exist "$interface_name" )
        then
            more_info $interface_name
        else
            echo "Invalid Interface Name .No such interface"
        fi
        break
        ;;
    "Modify Netowrk Settings" )
        read -p "Enter Interface Name: " interface
        if ( is_interface_exist "$interface_name" )
        then
            select setting in "Automatic" "Manual" "Back"
        do
            case $setting in
            "Automatic" )
                automatic_settings $interface 
                break;;
            "Manual" )
                manual_settings $interface
                break;;
            "Back" )
                break;;
            * )
                echo "Invalid option, please enter a valid one !" ;;
            esac
        done
        else
            echo "${newline}Invalid Interface Name .No such interface"
        fi
        
        break
        ;;
    "Back" )
        clear
        exit
        ;;
    * )
        echo "Invalid option, please enter a valid one !"        
    esac
done
done