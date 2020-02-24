#!/bin/bash

clear
COLUMNS=12
first='List_all_installed_packages'
second='Display_more_info_for_specific_package'
third="List_available_repos"
forth="Install_new_package"
fifth="Update_existing_package"
sixth="Remove_package"



select choice in $first $second $third $forth $fifth $sixth "Back"
do
case $choice in 

$first)

	yum list installed

	;;

$second)

	echo "Enter the package name"
	read pack

	yum info $pack


	;;


$third)

	yum repolist

	;;	

$forth)

	echo "Enter the package name"
	read pack

	yum install $pack

	;;


$fifth)


	 echo "Enter the package name"
        read pack

        yum update $pack

        ;;



$sixth)

        echo "Enter the package name"
        read pack

        yum remove $pack

        ;;
"Back" )
	clear 
	./main.sh
	;;

*)

	echo "$REPLY is not one of the choices"

	;;


esac
done
