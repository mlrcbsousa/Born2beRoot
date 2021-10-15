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
