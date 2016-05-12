#!/bin/bash
printf "Welcome to Pioneers team, demoing the Pi-Cloud\n"
printf "Getting IP of all slave nodes\n"
printf "Available hosts = ${HOSTNAME}\n"
printf "Enter name of host to install application on\n"
read -r this_host
printf "Enter the name of github application to download\n"
read -r link_name
printf $link_name"\n"
git clone  $link_name
extr=`echo $link_name | awk -F"/" '{print $NF}'`
printf $extr"\n"
extr2=`echo $extr | awk -F"." '{print $1}'`
printf $extr2"\n\n"
ls -ltrha $extr2
printf "Enter the port number to run this application \n"
read -r this_port
printf "Enter the dependencies seperated by space\n"
read -r depends
echo $depends
#sudo apt-get install `echo "$depends" | tr -d '"'`
#new_depends="$(echo "$depends" | tr -d '\"')"
#printf $new_depends
#sudo apt-get install $depends
fab set_hosts:$this_host
fab set_hosts:$this_host upload:"$extr2","~/"
fab set_hosts:$this_host sudorun:"apt-get update"
fab set_hosts:$this_host sudorun:"apt-get remove -y --auto-remove $depends"
fab set_hosts:$this_host install:"$depends"

printf "Adding Dynamic route for app $extr2 at host $this_host on port $this_port\n"
head -n -1 /etc/nginx/sites-enabled/cmpe273.com > temp.txt
cat << EOT >> temp.txt
	location /$extr2/ {
		proxy_pass http://$this_host:$this_port/;
	}
}
EOT
sudo mv temp.txt /etc/nginx/sites-enabled/cmpe273.com
sudo nginx
sudo nginx -s reload
fab set_hosts:$this_host cmdrun:"nodejs $extr2/*.js $this_port "
