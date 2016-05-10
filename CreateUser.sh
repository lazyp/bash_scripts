#!/bin/bash
_userName="X"
_isSetPasswd="X"
_uid="X"
_gid="X"
_isCreateHomeDir="X"
_homeDir="X"

echo -n "Please Enter User Name : "
read _userName
#echo $_userName

if [ -z $_userName ];then
        echo -e "\n\033[31m Please Enter The User Name.\033[0m \n"
	exit -1
fi

echo -n "If Create The Home Dir ? (y/Y/n/N) : "
read _isCreateHomeDir

if [ -z $_isCreateHomeDir ];then
	_isCreateHomeDir="N"
fi

#echo $_isCreateHomeDir

case $_isCreateHomeDir in
	y|Y)
		echo -n "Please Enter The Home Dir Name Is : "
		read _homeDir
		if [ -z $_homeDir ]; then
			sudo useradd -s "/bin/bash" -m $_userName
		else
			sudo useradd  -s "/bin/bash" -m -d $_homeDir $_userName
		fi
		;;
	n|N)
		sudo useradd -s "/bin/bash" $_userName
		;;
	*)
		echo "Input Error"
		exit -1
		;;
esac

if [ $? != 0 ];then
	echo "Create Linux User Fail."
	exit -1
fi 

echo -n "If Set The $_userName's Password :(y/Y/n/N) "
read _isSetPasswd

if [ -z $_isSetPasswd ]; then
	_isSetPasswd="N"
fi

if [ $_isSetPasswd = "y" ] || [ $_isSetPasswd = "Y" ]; then
     sudo  passwd $_userName
fi

echo "Create Linux User Success."
