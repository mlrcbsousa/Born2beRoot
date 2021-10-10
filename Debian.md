# Debian

Guide for the **Debian** version of the project.


## Installing `sudo`

Switch to root.
```bash
su -
```

Update Packages.
```bash
apt-get update
```

Install `vim`.
```bash
apt-get install vim
```

Install `sudo`.
```bash
apt install sudo
```

Verify if `sudo` was successfully installed.
```bash
dpkg -l | grep sudo
```


## Add User to `sudo` Group

Add user to **sudo** group.
```bash
adduser <username> sudo
```

Alternatively, add using `usermod`.
```bash
usermod -aG sudo <username>
```

Verify if user was successfully added to **sudo** group.
```bash
getent group sudo
```

Reboot for changes to take effect.
```bash
reboot
```

Log in and verify sudopowers.
```
<--->
Debian GNU/Linux 10 <hostname> tty1

~$ <hostname> login: <username>
~$ Password: <password>
<--->
```

```bash
sudo -v
```

```
~$ [sudo] password for <username>: <password>
```


## Running root-Privileged Commands

Run root commands with `sudo`.
```bash
sudo apt update
```


## Configuring `sudo`

Configure **sudo**. <filename> can not end in `~` or contain `.`.
Create files log all sudo commands.
```bash
sudo mkdir /var/log/sudo
sudo vi /etc/sudoers.d/sudoconfig
```

1.	To limit authentication using sudo to 3 attempts
2.	To add a custom error message in the event of an incorrect password
3.	To log all sudo commands
4.	To archive all sudo inputs & outputs
5.	"	"	"
6.	To require TTY
7.	To set sudo paths

```
Defaults      passwd_tries=3
Defaults      badpass_message="Not the correct Password!"
Defaults      logfile="/var/log/sudo/<filename>"
Defaults      log_input,log_output
Defaults      iolog_dir="/var/log/sudo"
Defaults      requiretty
Defaults      secure_path=""/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin""
```

