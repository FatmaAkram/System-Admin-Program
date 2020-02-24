#!/usr/bin/bash
clear
COLUMNS=12
function modifyUser()
{
 read -p "Enter user name : " userName;
    select choice in "Change Password" "Change Comment" "Change user ID" "Change group ID" "Change home directory" "Change Shell" "Back"
	do
	case $choice in
	"Change Password" )
		passwd $userName
	;;
	"Change Comment" )
		read -p "Enter Comment" comment
		sudo usermod $userName -c $comment

	;;
	"Change user ID" )
		read -p "Enter user id" usrid
		sudo usermod -u $usrid $userName
	;;
	"Change group ID" )
		read -p "Enter group id" grpId
		sudo usermod -g $grpId $userName
	;;
	"Change home directory" )
		read -p "Enter new Directory (full path): " dir
		if [ -d $dir ]
		then
			sudo usermod -d $dir $userName
		else
			echo "Wrong Entry"
		fi
	;;
	"Change Shell" )
		read -p "Enter shell " shellmodify
		case $shellmodify in
		"sh" | "Bourne Shell")
			sudo usermod --shell /bin/sh $userName
		;;
		"ksh" | "Korn Shell")		
			sudo usermod --shell /bin/ksh $userName
		;;
		"bash" |"Bourne Again Shell")
		 
		 	sudo usermod --shell /bin/bash $userName
		;;
		esac
	;;
	"Back" )
		exit
	;;
	esac
	done   
}


select choice in "List Users" "Add New User" "Modify"  "Remove" "Back"
do
    case $choice in
    "List Users" )
        echo "list of users is" ;
        awk -F ':' '{print $1}' /etc/passwd
    ;;
    "Add New User" ) 
        echo "Enter User Name : "
        read username
        sudo useradd $username
        sudo passwd $username
		read -p "Enter comment: " comment
		sudo useradd -c $comment $username
		read -p "Enter user id: " useId
		sudo useradd -u $useId $username
		

    ;;
    "Modify" )
        modifyUser
    ;;
    "Remove" )
        echo "enter user name you want to delete"
		read userName
		sudo userdel $userName
    ;;
    "Back")
        clear
		./main.sh
    ;;
    * )
     echo "${REPLY} is not one of the choices."
    esac
done
