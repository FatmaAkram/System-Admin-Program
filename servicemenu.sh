
#!/bin/bash
clear
COLUMNS=12
PS3='Enter Your choice : '
echo "* Services of system: select from the following *"
select menu in "Display all running services" "Display stopped services" "Display failed services" "Display more info about specific services" "Manage specific service" "Back"
do
case $menu in 
	"Display all running services")
		echo "Feel free to press 'q' to exit "
		read
		echo "All running services ......"
		systemctl list-units --type service --state running
	;;
	"Display stopped services")
		systemctl list-units --type service --state inactive

	;;
	"Display failed services")
		
		systemctl list-units --type service --state failed
	;;
	"Display more info about specific services")

		echo "Enter the name of the service "
		while :
		read name
		do
			case "$name" in
			""|*[0-9]*)
			echo "Not valid, please enter the name again";
			continue
			;;
			*)
			 systemctl -l status $name.service
			break;
			;;
			esac
		done
	;;
	"Manage specific service")

		echo "Enter the name of the service "
                read name
				while ( -z "$name")
		do
			echo "Not valid, please enter the name again";
			read name;
		done
		echo "choose required action "
		select action in "Status" "Start" "Stop" "Restart" "Enable" "Disable" "Back"
		do
			case $action in 
				
				"Status")
					systemctl status  $name.service
				;;
				"Start")
					systemctl start $name.service
				;;
				"Stop")
					systemctl stop $name.service
				;;
				"Restart")
					systemctl restart $name.service
				;;
				"Enable")
					systemctl enable $name.service
				;;
				"Disable")
					systemctl disable $name.service
				;;
				"Back")
					break;
				;;
				*)
					echo "Wrong service name"
				;;
			esac
		done


	;;	
	"Back")
		clear
		./main.sh
	;;	
	*)
		echo "Wrong Option"
esac
done
