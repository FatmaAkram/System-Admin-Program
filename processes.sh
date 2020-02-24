#!/usr/bin/bash
clear
COLUMNS=12
select choice in "Processes For Specific User" "Process Details" "Kill Process"  "Change Priority " "Back" 
do
    case $choice in
    "Processes For Specific User" ) 
        echo "Please enter UserName :" 
        read  UserName 
        ps -u $UserName 
    ;;
    "Process Details" ) 
        echo "Please enter process name"
        read PSName 
        echo $UserName 
        echo $PSName
        if [ -z "$(pgrep $PSName)" ]
        then
            echo "Wrong Entry"
        else
            ps -p $(pgrep $PSName);
        fi
             
    ;;
    "Kill Process" ) 
        echo "Please enter signal no. (1=SIGHUB 9=SIGKILL 15=SIGTERM):"
        read signalNO
        echo "please enter Process ID :" 
        read PID
        kill $signalNO $PID  
    ;;
    "Change Priority" ) 
        echo "Please enter process ID :" 
        read PID
        echo "Please enter nice value (range from -20 to 19):"
        read NiceValue
        renice $NiceValue -p $PID
    ;;
    "Back" )
        clear 
        ./main.sh
    ;;
    * ) 
        echo $REPLY is not one of the choices.
    esac
done
