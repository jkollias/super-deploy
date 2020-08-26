#!/bin/bash

#check if $1 is
if [ -z $1 ]; then 
 	site_dir=$PWD; 
else  
	site_dir=$1;
fi 

#colors
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 3)
bold=$(tput bold)
normal=$(tput sgr0)

#Magento Commands
function magento_setup_upgrade {
	echo "Upgrading"
	echo "bin/magento setup:upgrade"
	sudo php -dmemory_limit=5G $site_dir/bin/magento setup:upgrade
}

function magento_compile {
	echo "Compiling"
	echo "bin/magento setup:di:compile"
	sudo php -dmemory_limit=5G $site_dir/bin/magento setup:di:compile
}

function magento_deploy {
	echo "Deploying"
	echo "bin/magento setup:static-content:deploy"
	sudo rm -rf $site_dir/var/static/frontend/*
	sudo rm -rf $site_dir/var/cache
	sudo rm -rf $site_dir/var/view_preprocessed/
	sudo rm -rf $site_dir/pub/static/frontend/
	sudo php -dmemory_limit=5G $site_dir/bin/magento setup:static-content:deploy -f
	sudo chmod -R 777 $site_dir/generated
	sudo chmod -R 777 $site_dir/var
	sudo chmod -R 777 $site_dir/pub
}

echo " "
echo "You have chosen the site found in ${bold} ${site_dir} ${normal}"
echo " "
echo "${bold}What would you like to do?${normal}"
echo "[1] Upgrade data base schema and data"
echo "[2] Compile"
echo "[3] Deploy" 
echo "[4] All"
echo "[5] I dont want to do any of this. Cancel!"

read command_to_run

if   [ "$command_to_run" == "1" ]; then    
    magento_setup_upgrade
elif [ "$command_to_run" == "2" ]; then 
    magento_compile
elif [ "$command_to_run" == "3" ]; then  
	magento_deploy
elif [ "$command_to_run" == "4" ]; then 
	magento_setup_upgrade
	magento_compile
    magento_deploy
elif [ "$command_to_run" == "5" ]; then
	echo "${white}Cancelled."	
else
    echo "${white}Cancelled. Please choose 1-4."
    exit
fi

echo "Finished."

