#!/usr/bin/bash
clear
COLUMNS=12
echo "##### System Admin Program #####"
PS3='Enter a choice : '
select name in "Process Management" "Service Management" "User Management" "Software Management" "Network Management" "Security Management" "Quit"
do
    case $name in 
    "Process Management" )
        ./processes.sh
        ;;
    "Service Management" )
        ./servicemenu.sh
        ;;
    "User Management" )
        ./user.sh
        ;;
    "Software Management" )
        ./software.sh
        ;;
    "Network Management" )
        ./network.sh
        clear
        ;;
    "Security Management" )
        ./security.sh
        ;;
    "Quit" ) 
        exit
        ;; 
    esac
done