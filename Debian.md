# Debian

Guide for the **Debian** version of the project.

### Installing `sudo`

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

### Add User to `sudo` Group

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
