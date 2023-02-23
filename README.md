# What is this?
This repository contains all the files you need to start a Wordpress website accelerated by PHP-FPM and a MariaDB database, all contained in a Docker stack.

# Getting Started
## 1. Install Docker Engine
This is beyond the scope of this article. Please follow the instructions at https://docs.docker.com/engine/install/
After you've installed Docker, please follow the Post-installation steps here (Steps 1-3): https://docs.docker.com/engine/install/linux-postinstall/

## 2. Clone The Repository
1. In the command line, navigate to the folder you'd like to be the home for your wordpress installation. I recommend your user's home folder (~) or (/home/user).
2. Clone the repository.
```
git clone https://github.com/ahildebrand12/wordpress-stack
```
3. You'll now have a folder called "wordpress-stack" in your chosen directory. This will be the name of your docker stack. Rename this folder to whatever you'd like to name your stack.
```
mv wordpress-stack mywordpresssite
```
4. CD into the folder.
```
cd mywordpresssite
```

## 3. Set Variables
Inside the mywordpresssite folder, there is a file called example.env. You'll want to open this file with nano and edit the variables.
```
nano example.env
```
You'll see a file that looks like this. Fill in these variables with the necessary information. Once you're done, use the CTRL+O keys to save, and CTRL+X to exit.
```
MYSQL_ROOT_PASSWORD=
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
WORDPRESS_TAG=php8.1-fpm
WORDPRESS_HTTP_PORT=8080
PHPMYADMIN_PORT=8081
```
Then rename the file to .env from example.env
```
mv example.env .env
```

## 4. Launch Site
Run the following command to bring up the site. After it's online, it can take a minute to initialize the database. Once it's done, the site will be accessible at the WORDPRESS_HTTP_PORT you set.
```
docker compose up -d
```



### Running Behind A Reverse Proxy
If you're getting a redirect loop, you'll need to add the following code to your wp-config.php file.

```
define('FORCE_SSL_ADMIN', true);
// in some setups HTTP_X_FORWARDED_PROTO might contain 
// a comma-separated list e.g. http,https
// so check for https existence
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
$_SERVER['HTTPS']='on';
```

### Setting up SQL Backup Cron Job
1. Install cron service. 
```
sudo apt install cron
```
2. Edit crontab file.
```
sudo /etc/crontab
```
3. Add the following cron job. This one will run every dat at 9PM. Be sure to actually edit the values in the mysqldump.sh file before adding cron job.
```
0 9 * * *       root    sh /path/to/mysqldump/mysqldump.sh
```

### Change PHP Values (Memory and Upload Limit)
1. In the php folder, edit the php.ini file.
```
nano php.ini
```
2. The contents will look like this. You can adjust the values to your preference.
```
file_uploads = On
memory_limit = 512M
upload_max_filesize = 100M
post_max_size = 100M
max_execution_time = 300
max_input_time = 1000
```

## Activate Redis Object Cache
1. Add the following to the wp-config.php file in the html folder.
```
define('WP_REDIS_HOST', 'redis');
```

2. Install the "Redis Object Cache" plugin.
3. In the plugin settings, click Enable Cache.

## Folder Permissions
Sometimes the folder permissions for the container directories can get reset for a variety of reasons, such as restoring the directory from a backup. Below are the required permissions for each folder
