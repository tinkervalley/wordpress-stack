NOW=`date '+%F_%H:%M:%S'`;
docker exec -it [CONTAINERNAME] mysqldump -u root -p[SQLROOTPASSWORD] [DATABASENAME] > /path/to/folder/containing/this/file/sqldump-$NOW.sql
#This script will create a .sql file with the current date and time.
