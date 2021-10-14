# Debian

Guide for the **Debian** version of the project.

Install `vim`.

```bash
apt-get install vim
```

Verify any package installation with `dpkg`
```bash
dpkg -l | grep $PACKAGE_NAME
```

## 1 - Installing sudo & adding it in groups

```bash
su - # ?
apt install sudo
sudo adduser msousa sudo
sudo reboot
sudo -v # ?
sudo addgroup user42
sudo adduser msousa user42
sudo apt update
```

Verify if user was successfully added to **sudo** group.
```bash
getent group sudo
```

## 2 - Installing SSH

```bash
sudo apt install openssh-server
sudo vi /etc/ssh/sshd_config
```

`#Port 22` to `Port 4242` and
`#PermitRootLogin prohibit-password` to `PermitRootLogin no` 

Diference between `sshd_config` and `ssh_config`?

```bash
sudo vi /etc/ssh/ssh_config
```
`#Port 22` to `Port 4242`

```bash
sudo reboot # for changes to take effect
sudo service ssh status
```
Apply port forwarding rule on VirtualBox can be `4242:4242`.

`ssh` into VM
```bash
ssh msousa@127.0.0.1 -p 4242 # or
ssh msousa@0.0.0.0 -p 4242 # or
ssh msousa@localhost -p 4242
```

## 3 - Installing UFW

```bash
sudo apt install ufw
sudo ufw enable
sudo ufw allow 4242
sudo ufw status
```

## 4 - Configuring sudo

```bash
sudo touch /etc/sudoers.d/sudoconfig
sudo mkdir /var/log/sudo
sudo vi /etc/sudoers.d/sudoconfig
```

`# /etc/sudoers.d/sudoconfig`

```
Defaults    passwd_tries=3
Defaults    badpass_message="Incorrect sudo password, you have a total of 3 tries."
Defaults    log_input,log_output 
Defaults    iolog_dir="/var/log/sudo"
Defaults    requiretty
Defaults    secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
```

## 5 - Setting up a strong password policy

```bash
sudo vi /etc/login.defs
```

```
PASS_MAX_DAYS    99999 -> PASS_MAX_DAYS    30
PASS_MIN_DAYS    0     -> PASS_MIN_DAYS    2
```

`PASS_WARN_AGE` is 7 by defaults.

```bash
sudo apt install libpam-pwquality
sudo vi /etc/pam.d/common-password
```

Add to the end of the `password requisite pam_pwqiality.so retry=3` line:

```
minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root
```

Change previous passwords.

```bash
passwd
sudo passwd
```

## `cron`

Create script file

```bash
sudo vi /home/monitoring.sh
```

Make executable

```bash
sudo chmod +x /home/monitoring.sh
```

Edit cron jobs

```bash
sudo crontab -u root -e
```

After line23 `# m h  dom mon dow   command`

Put line24 `*/10 * * * * /home/monitoring.sh` 

Check scheduled jobs

```bash
sudo crontab -u root -l
```

# dont, needed to run package manager
### Disable `dhcpclient` open port 68

```bash
sudo vi /etc/network/interfaces
```

Comment out `iface enp0s3 inet dhcp`

```bash
sudo reboot
```


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




