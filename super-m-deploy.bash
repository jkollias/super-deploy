#colors
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 3)
white=$(tput sdr0) # No Color

#weights
bold=$(tput bold)
normal=$(tput sgr0)


echo "${bold}What would you like to do?${normal}"
echo "[1] Upgrade data base schema and data"
# bin/magento setup:upgrade
# Use when you disable/enable or update a component

echo "[2] Compile"
# bin/magento setup:di:compile
# Use when you disable/enable or update a component

echo "[3] Deploy"
# bin/magento setup:static-content:deploy
# Generate static content

echo "[4] All"

read command_to_run

if   [ "$command_to_run" == "1" ]; then
    echo "${red}bin/magento setup:upgrade"
elif [ "$command_to_run" == "2" ]; then
    echo "${green}bin/magento setup:di:compile"
elif [ "$command_to_run" == "3" ]; then
	echo "${blue}bin/magento setup:static-content:deploy"
elif [ "$command_to_run" == "4" ]; then
	echo "${red}bin/magento setup:upgrade"
	echo "${green}bin/magento setup:di:compile"
	echo "${blue}bin/magento setup:static-content:deploy"
else
    echo "${white}Cancelled. Please choose 1-4"
    exit
fi

echo "${white}bin/magento c:c && bin/magento c:f" 