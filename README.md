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
