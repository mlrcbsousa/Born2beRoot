# Evaluation Questions

Create a `signature.txt` of the virtual machine image

```bash
sha1sum ~/VirtualBox\ VMs/Born2beRoot/Born2beRoot.vdi > signature.txt
```

## How a Virtual Machine works

A virtual machine uses software emulation of hardware to create an isolated environment on top of hardware where a separate system with its own OS can be run. Therefore allowing for things like running Debian inside a Mac.

## Choice of Operating System

It's easier to install and configure than CentOS (and I haven't used CentOS before). I use Ubuntu and Pop OS for personal use which are both Debian flavours and wanted to understand them more deeply.

## The basic differences between CentOS and Debian

CentOS vs Debian are two flavors of Linux operating systems. CentOS, as said above, is a Linux distribution. It is free and open-source. It is enterprise-class – industries can use meaning for server building; it is supported by a large community and is functionally supported by its upstream source, Red Hat Enterprise Linux. Debian is a Unix like computer operating system that is made up of open source components. It is built and supported by a group of individuals who are under the Debian project.

Debian uses Linux as its Kernel. Fedora, CentOS, Oracle Linux are all different distribution from Red Hat Linux and are variant of RedHat Linux. Ubuntu, Kali, etc., are variant of Debian. CentOS vs Debian both are used as internet servers or web servers like web, email, FTP, etc.

## The purpose of virtual machines

VMs may be deployed to accommodate different levels of processing power needs, to run software that requires a different operating system, or to test applications in a safe, sandboxed environment.

## The difference between `aptitude` and `apt`

Aptitude is a higher-level package manager while APT is lower-level package manager which can be used by other 
higher-level package managers.

Aptitude is vaster in functionality than **apt-get** and integrates functionalities of **apt-get** and its other variants including **apt-mark** and **apt-cache**.

[Read more](https://www.tecmint.com/difference-between-apt-and-aptitude/)

## What is APPArmor

Check APPArmor status

```bash
sudo aa-status
```

AppArmor ("Application Armor") is a Linux kernel security module that allows the system administrator to restrict programs' capabilities with per-program profiles.

Profiles can allow capabilities like network access, raw socket access, and the permission to read, write, or execute files on matching paths.

[Read more](https://en.wikipedia.org/wiki/AppArmor)
## Check

- [x] Script running every 10min
- [x] No graphical user interface
- [x] Password requested on boot up
- [x] Login with `msousa`
- [x] Password must follow rules

## Check that the UFW service is started

```bash
sudo ufw status
```

## Check that the SSH service is started

```bash
sudo service ssh status
```

## Check that the operating system is Debian

```bash
cat /etc/os-release | grep PRETTY_NAME
```

## Check that `msousa` is member of `sudo` and `user42` groups

```bash
groups msousa
```

## Check password policy rules

Password expiry: line 160 and 161.

```bash
vi /etc/login.defs
```

Password policy: line 25.

```bash
vi /etc/pam.d/common-password
```

### Create a new user

```bash
sudo adduser new_user
```

### Assign password

Confirm it follows the password policy

### Explain how password rules were setup

```bash
vi /etc/pam.d/common-password
```

## Create group `evaluating` and add created user

```bash
sudo addgroup evaluating
sudo adduser new_user evaluating
```

### Check that user belongs to new group

```bash
groups new_user
```

## Explain advantages of password policy and advantages and disadvantages of policy implementation

In theory, the main benefit of password complexity rules is that they enforce the use of unique passwords that are harder to crack. The more requirements you enforce, the higher the number of possible combinations of letters, numbers, and characters.

Password complexity rules try to enforce this “difficult to crack” requirement, but they aren’t always successful. This is partly to do with the diminishing returns involved in increasing complexity

How much better is a 15 character password than a 30 character password if hackers know that longer password is frequently used? And is it better if the user can’t remember the password? Password complexity only scales up to a certain point. Beyond a certain point, a complex password can be difficult to crack if the number of possible combinations is extremely high, but it can also be too complex to be useful to users.

## Check that the hostname of the machine is `msousa42`

```bash
uname -n
# or 
hostname
```

## Modify hostname with evaluator login and reboot to confirm change

```bash
sudo adduser new_user sudo
sudo login new_user
sudo vi /etc/hostname # change to new_user42
sudo reboot
```

### Restore original hostname

```bash
sudo vi /etc/hostname # change to msousa42
sudo reboot
```

## How to view partitions

```bash
lsblk
```

### Compare partition output with example in subject

```bash
NAME                    MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                       8:0    0    8G  0 disk  
|-sda1                    8:1    0  476M  0 part  /boot
|-sda2                    8:2    0    1K  0 part  
`-sda5                    8:5    0  7.5G  0 part  
  `-sda5_crypt          254:0    0  7.5G  0 crypt 
    |-LVMGroup-root     254:1    0  1.9G  0 lvm   /
    |-LVMGroup-swap     254:2    0  952M  0 lvm   [SWAP]
    |-LVMGroup-home     254:3    0  952M  0 lvm   /home
    |-LVMGroup-var      254:4    0  952M  0 lvm   /var
    |-LVMGroup-srv      254:5    0  952M  0 lvm   /srv
    |-LVMGroup-tmp      254:6    0  952M  0 lvm   /tmp
    `-LVMGroup-var--log 254:7    0    1G  0 lvm   /var/log
sr0                      11:0    1 1024M  0 rom
```

## Brief explanation of how LVM works

It works by chunking the physical volumes (PVs) into physical extents (PEs). The PEs are mapped onto logical extents (LEs) which are then pooled into volume groups (VGs). These groups are linked together into logical volumes (LVs) that act as virtual disk partitions and that can be managed as such by using LVM.

[Read more](https://searchdatacenter.techtarget.com/definition/logical-volume-management-LVM)

## What is LVM about

Logical volume management (LVM) is a form of storage virtualization that offers system administrators a more flexible approach to managing disk storage space than traditional partitioning. The goal of LVM is to facilitate managing the sometimes conflicting storage needs of multiple end users.

## Check `sudo` program is properly installed

```bash
dpkg -l | grep sudo
```

## Assign new user to `sudo` group

```bash
sudo adduser new_user sudo
```

## Explain value and operation of sudo using examples

Sudo stands for SuperUser DO and is used to access restricted files and operations. By default, Linux restricts access to certain parts of the system preventing sensitive files from being compromised.

The sudo command temporarily elevates privileges allowing users to complete sensitive tasks without logging in as the root user.

```bash
apt-get update # Error 13: Permission denied
sudo apt-get update
```

[Read more](https://phoenixnap.com/kb/linux-sudo-command)

## Show the implementation of the subject rules

```bash
vi /etc/sudoers.d/sudoconfig
```

[What is TTY](https://www.howtogeek.com/428174/what-is-a-tty-on-linux-and-how-to-use-the-tty-command/)

## Verify that the `/var/log/sudo/` folder exists and has a file

```bash
sudo ls /var/log/sudo/
```

Has file `seq`.

### Check contents of files in this folder

```bash
sudo ls /var/log/sudo/00/00
# run sudo command
sudo ls /var/log/sudo/00/00/<newfolder> 
```

### Check there is a history of commands using sudo

```bash
sudo cat /.../log # Input log
sudo cat /.../ttyout # Output log
```

### Run a command using sudo and check if files updated

```bash
sudo apt update
sudo ls /var/log/sudo/00/00 # should have new folder
```

## Check that UFW is properly installed

```bash
dpkg -l | grep ufw
```

### Check that it is working properly

```bash
sudo ufw status
```

### Explain what UFW is and the value of using it

Uncomplicated Firewall is a program for managing a netfilter firewall designed to be easy to use. It uses a command-line interface consisting of a small number of simple commands, and uses iptables for configuration.

UFW aims to provide an easy to use interface for people unfamiliar with firewall concepts, while at the same time simplifies complicated iptables commands to help an administrator who knows what he or she is doing.

[Read more](https://wiki.ubuntu.com/UncomplicatedFirewall)

### List active rules should include one for port 4242

```bash
sudo ufw status | grep 4242
```

### Add a new rule for port 8080

```bash
sudo ufw allow 8080
sudo ufw status
```

### Delete the new rule

List rules numbered

```bash
sudo ufw status numbered
```

Delete rule

```bash
sudo ufw delete $NUMBER
```

## Check that the SSH service is properly installed

```bash
dpkg -l | grep openssh-server
```

### Check that it is working properly

```bash
sudo service ssh status
```

### Explain what SSH is and the value of using it

Secure Shell (SSH) is a cryptographic network protocol for operating network services securely over an unsecured network. Typical applications include remote command-line, login, and remote command execution, but any network service can be secured with SSH.

SSH provides password or public-key based authentication and encrypts connections between two network endpoints. It is a secure alternative to legacy login protocols (such as telnet, rlogin) and insecure file transfer methods (such as FTP).

[Read more](https://en.wikipedia.org/wiki/Secure_Shell)

### Verify that the SSH service only uses port 4242

```bash
sudo service ssh status | grep listening
# or check configs
sudo vi /etc/ssh/sshd_config
sudo vi /etc/ssh/ssh_config 
```

### Login with SSH from host machine

```bash
ssh msousa@127.0.0.1 -p 4242 # or
ssh msousa@0.0.0.0 -p 4242 # or
ssh msousa@localhost -p 4242
```

### Make sure you cannot SSH login with root user

```bash
msousa@msousa42:~$ login root
login: Cannot possibly work without effective root
```

## Explanation of the monitoring script by showing the code

### architecture

```bash
architecture=$(uname -a)
```

uname (short for unix name) is a computer program in Unix and Unix-like computer operating systems that prints the name, version and other details about the current machine and the operating system running on it.

### physical_cpu

[Read more](https://www.cyberciti.biz/faq/check-how-many-cpus-are-there-in-linux-system/)

```bash
physical_cpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
# or
lscpu | grep "CPU(s)"
```

Use `/proc/cpuinfo` file that lists CPUs.

### virtual_cpu

[Read more](https://webhostinggeeks.com/howto/how-to-display-the-number-of-processors-vcpu-on-linux-vps/)

If your processors are multi-core, you need to know how many virtual processors you have. You can count those by looking for lines that start with "processor".

[Read more](https://www.networkworld.com/article/2715970/counting-processors-on-your-linux-box.html)

```bash
virtual_cpu=$(grep -c ^processor /proc/cpuinfo)
```

`-c` flag is a count on the `grep`

### memory_usage

[`awk` built-in variables](https://www.thegeekstuff.com/2010/01/8-powerful-awk-built-in-variables-fs-ofs-rs-ors-nr-nf-filename-fnr/)

[Read more](https://linuxcommando.blogspot.com/2008/04/using-awk-to-extract-lines-in-text-file.html)

```bash
memory_usage=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
```

### total_disk

```bash
total_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
```

`df` disk utility, `-Bg` displays in Gigabytes.

`ft` is a variable name, `END` stops the command from reaching the print until it has gone through all the lines.

Add-up total.

`-v` flag on `grep` returns non-matching lines.

### used_disk

```bash
used_disk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
```

`-Bm` displays in Megabytes.

Add-up used.

### percent_used_disk

```bash
percent_used_disk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
```

Need to do the same as before but both in the same measuring unit to get a meaningful percentage.

### cpu_load

```bash
cpu_load=$(top -bn1 | grep load | awk '{printf "%.2f%%\n", $(NF-2)}')
```

[`top` utility](https://man7.org/linux/man-pages/man1/top.1.html)

`-b` flag for batch mode, allows to pipe output to file or another command.
`-n1` flag for 1 interation.
`NF` number of fields in the record (row), `$(NF-2)` selects the thrid counting from the last.

### last_boot

```bash
last_boot=$(who -b | awk '$1 == "system" {print $3 " " $4}')
```

`who -b` shows time of last system boot.

### lvm_partitions

```bash
lvm_partitions=$(lsblk | grep -c "lvm")
```

Count `lvm` type partitions from `lsblk` command output.

### lvm_is_used

```bash
lvm_is_used=$(if [ $lvm_partitions -eq 0 ]; then echo no; else echo yes; fi)
```

Conditional to check if previous variable is zero or not.

### tcp_connections

```bash
# [$ sudo apt-get install net-tools]
tcp_connections=$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}')
```

[Read more](https://unix.stackexchange.com/questions/67150/getting-current-tcp-connection-count-on-a-system)

`/proc/net/sockstat{,6}` fies include connections established count.

Find line where first is `TCP:` and print third value which is the `inuse` (in use) amount.

### users_logged_in

```bash
users_logged_in=$(w -h | wc -l)
```

`w` - Show who is logged on and what they are doing.
`-h` flag is without header.
Each line has info about a logged in user.
Count of lines is how many users logged in.

### ipv4_address

```bash
ipv4_address=$(hostname -I)
```

`-I` flag to display IP address.

### mac_address

```bash
mac_address=$(ip link show | awk '$1 == "link/ether" {print $2}')
```

`ip` util with `link` object, then select line where `link/ether` is and print second column: MAC address.

### sudo_commands_count

```bash
sudo_commands_count=$(journalctl _COMM=sudo | grep -c COMMAND)
```

[Read more](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)

If a file path refers to an executable script, a "_COMM=" match for the script name is added to the query.

## What is `cron`

The cron command-line utility, also known as cron job is a job scheduler on Unix-like operating systems. Users who set up and maintain software environments use cron to schedule jobs (commands or shell scripts) to run periodically at fixed times, dates, or intervals. It typically automates system maintenance or administration—though its general-purpose nature makes it useful for things like downloading files from the Internet and downloading email at regular intervals.

[Read more](https://en.wikipedia.org/wiki/Cron)

### How to set up the script to run every 10mins

```bash
sudo crontab -e
```

Add following line

```
*/10 * * * * /home/monitoring.sh
```

### Verify correct functioning of the script

Check print out in console.

### Change run of script to every minute

```bash
sudo crontab -e
```

Add following line

```
*/1 * * * * /home/monitoring.sh
```

### Make the script stop running after reboot without modifying it

Remove the scheduling line on the crontab

```bash
sudo crontab -e
```

Remove following line/s

```
@reboot /home/monitoring.sh
*/1 * * * * /home/monitoring.sh
```

- [x] Restart server
- [x] Check script still exists in the same place
- [x] Check that its rights have remained the same
- [x] Check that it has not been modified