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

## Check that the SSH service is properly installed

### Check that it is working properly

### Explain what SSH is and the value of using it

### Verify that the SSH service only uses port 4242

### Login with SSH from host machine

### Make sure you cannot SSH login with root user

## Explanation of the monitoring script by showing the code

## What is `cron`

### How to set up the script to run every 10mins

### Verify correct functioning of the script

### Change run of script to every minute

### Make the script stop running after reboot without modifying it

- [x] Restart server
- [x] Check script still exists in the same place
- [x] Check that its rights have remained the same
- [x] Check that it has not been modified