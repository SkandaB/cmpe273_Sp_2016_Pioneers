server {
	listen 80 default_server;
	listen [::]:80 default_server;



	root /var/www/cmpe273.com/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;
	location /cmpe273proj/ {
		proxy_pass http://raspberrypi:4400/;
	}
}
