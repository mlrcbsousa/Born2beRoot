
# Linux Lighttpd MariaDB PHP (LLMP) Stack

## Step 1: Installing Lighttpd

```bash
sudo apt install lighttpd
```

Allow incoming connections using Port 80

```bash
sudo ufw allow 80
```


## Step 2: Installing & Configuring MariaDB


```bash
sudo apt install mariadb-server
```

Start interactive script to remove insecure default settings

```bash
sudo mysql_secure_installation
```

Enter current password for root (enter for none): #Just press Enter (do not confuse database root with system root)

```
Set root password? [Y/n] n
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

Log in to the MariaDB console via sudo mariadb.

```bash
sudo mariadb
```

```
CREATE DATABASE paxfamilia;
```

Create new database user and grant them full privileges on the newly-created database

```
GRANT ALL ON paxfamilia.* TO '<username-2>'@'localhost' IDENTIFIED BY '<password-2>' WITH GRANT OPTION;
```

Flush the privileges
```
FLUSH PRIVILEGES;
```

Exit the MariaDB shell via exit.

```
exit
```

Verify whether database user was successfully created by logging in to the MariaDB console

```bash
mariadb -u <username-2> -p
```

Confirm whether database user has access to the database

```
SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| paxfamilia         |
| information_schema |
+--------------------+
```


## Step 3: Installing PHP

Install php-cgi & php-mysql.

```bash
sudo apt install php-cgi php-mysql
```

## Step 4: Downloading & Configuring WordPress

Install _wget_.

```bash
sudo apt install wget
```

Download WordPress to `/var/www/html`.

```bash
sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
```

Extract downloaded content.

```bash
sudo tar -xzvf /var/www/html/latest.tar.gz
```

Remove tarball.

```bash
sudo rm /var/www/html/latest.tar.gz
```

Copy content of `/var/www/html/wordpress` to `/var/www/html`.

```bash
sudo cp -r /var/www/html/wordpress/* /var/www/html
```

Remove `/var/www/html/wordpress`

```bash
sudo rm -rf /var/www/html/wordpress
```

Create WordPress configuration file from its sample.

```bash
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
```

Configure WordPress to reference previously-created MariaDB database & user.

```bash
sudo vi /var/www/html/wp-config.php
```

Replace the below

```
line23 define( 'DB_NAME', 'database_name_here' );
line26 define( 'DB_USER', 'username_here' );
line29 define( 'DB_PASSWORD', 'password_here' );
```

with:

```
line23 define( 'DB_NAME', '<database-name>' );
line26 define( 'DB_USER', '<username-2>' );
line29 define( 'DB_PASSWORD', '<password-2>' );
```

### Step 5: Configuring Lighttpd

Enable below modules.

```bash
sudo lighty-enable-mod fastcgi
sudo lighty-enable-mod fastcgi-php
sudo service lighttpd force-reload
```
