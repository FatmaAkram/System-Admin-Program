#!/usr/bin/bash
COLUMNS=12
function SElinux_settings()
{
        clear        
	SEmode="SElinux_mode"
        changetemp="Change_mode_temporary"
        changeperm="Change_mode_permenant"
	back="back"
        clear
        select choice2 in $SEmode $changetemp $changeperm $back
	do
        case $choice2 in
        $SEmode)
                getenforce
        ;;
        $changetemp)
                echo "please enter mode"
                read mode
                case $mode in
                "Enforcing"|"enforcing")
                        sudo setenforce 1
                ;;
                "permissive"|"Permissive")
                        sudo setenforce 0
                ;;
                "disabled"|"Disabled")
                        echo "system will restart to apply changes"
                        enforcemode="$(getenforce)"
                        sudo sed -i "s/${enforcemode}/disabled/I" /etc/selinux/config
                        shutdown -r now
               ;;
                esac
        ;;
        $changeperm)
                echo "please enter mode"
                read mode
                #select mode in Enforcing enforcing permissive Permissive disabled Disabled
                #do
                case $mode in
                "Enforcing"|"enforcing")
                        echo "system will restart to apply changes"
                        enforcemode="$(getenforce)"
                        sudo sed -i "s/${enforcemode}/enforcing/I" /etc/selinux/config
                        shutdown -r now
                ;;
                "permissive"|"Permissive")
                        echo "system will restart to apply changes"
                        enforcemode="$(getenforce)"
                        sudo sed -i "s/${enforcemode}/permissive/I" /etc/selinux/config
                        shutdown -r now
                ;;
                "disabled"|"Disabled")
                        echo "system will restart to apply changes"
                        enforcemode="$(getenforce)"
                       	sudo sed -i "s/${enforcemode}/disabled/I" /etc/selinux/config
                        shutdown -r now
		;;
		esac
        ;;
	$back)
		clear
		mainMenu

	;;
	*)
		echo "wrong choice please choose another one"
                
	;;
	esac
	done
}
function firewall()
{
        checkStatus="check_status"
        enableFirewall="Enable_firewall"
        disableFirewall="Disable_firewall"
        addService="Add_service"
        addPort="Add_port"
	back="back"
	clear
	select ch in $checkStatus $enableFirewall $disableFirewall $addService $addPort $back
        do
	case $ch in
        $checkStatus)
                systemctl status firewalld
                status="$(systemctl status firewalld|grep -e "inactive")"
                if [ -z "$status" ]
                then
                        service firewalld start
                fi
        ;;
        $enableFirewall)
                service firewalld start
        ;;
        $disableFirewall)
                service firewalld stop
        ;;
        $addService)
		status="$(systemctl status firewalld|grep -e 'inactive')"
                if [  ! -z "$status" ]
                then
			echo "firewall disabled ,please wait while enabling it"
                        service firewalld start
                fi
                echo "Enter service name"
                read service
                services="$(firewall-cmd --list-all | grep -e ${service} )"
                if [ -z "${services}" ]
                then
                        firewall-cmd --add-service=$service
                else
			echo "service already added ,choose another service"
                        
                fi
        ;;
        $addPort)
		status="$(systemctl status firewalld|grep -e "inactive")"
                if [  ! -z "$status" ]
                then 
                        echo "firewall disabled ,please wait while enabling it"
                        service firewalld start
                fi
                echo "Enter port"
                read port
                ports="$(firewall-cmd --list-all |grep -e ${port})"
                if [ -z "${ports}" ]
                then
                        firewall-cmd --add-port=${port}
                else
                        echo "port is already opened, choose another port"
                        
                fi
        ;;
	$back)
		clear
		mainMenu
	;;
        *)
		clear
                echo "wrong choice please choose another one"
                
        ;;
        esac
	done
}
function mainMenu()
{
	clear
        printf "please choose one\n
        1. SElinux Settings\n
        2. firewall configuration\n
        3. Back\n"

        read choice
        case $choice in
        1)
                echo "choice one"
                SElinux_settings
        ;;
        2)
                echo "choice two"
                firewall
        ;;
        3)
                clear
                 ./main.sh
                ;;
        *)
		clear
                echo "wrong choice please choose another one"
                mainMenu
        ;;
       
        esac
}
mainMenu

