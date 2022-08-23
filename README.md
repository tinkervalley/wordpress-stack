# Wordpress PHP-FPM Dockder
Docker Stack with Wordpress, PHP-FPM, and Nginx.


# Running Behind A Reverse Proxy
If you're getting a redirect loop, you'll need to add the following code to your wp-config.php file.

```
define('FORCE_SSL_ADMIN', true);
// in some setups HTTP_X_FORWARDED_PROTO might contain 
// a comma-separated list e.g. http,https
// so check for https existence
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
$_SERVER['HTTPS']='on';
```

# Setting up SQL Backup Cron Job
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

# Change PHP Values (Memory and Upload Limit)
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
