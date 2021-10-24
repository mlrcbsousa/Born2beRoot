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

## Create group `evaluating` and add created user

### Check that user belongs to new group

## Explain advantages of password policy and advantages and disadvantages of policy implementation

## Check that the hostname of the machine is `msousa42`

## Modify hostname with evaluator login and reboot to confirm change

### Restore original hostname

## How to view partitions

### Compare partition output with example in subject

## Brief explanation of how LVM works

## What is LVM about

## Check `sudo` program is properly installed

## Assign new user to `sudo` group

## Explain value and operation of sudo using examples

## Show the implementation of the subject rules

## Verify that the `/var/log/sudo/` folder exists and has a file

### Check contents of files in this folder

### Check there is a history of commands using sudo

### Run a command using sudo and check if files updated

## Check that UFW is properly installed

### Check that it is working properly

### Explain what UFW is and the value of using it

### List active rules should include one for port 4242

### Add a new rule for port 8080

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