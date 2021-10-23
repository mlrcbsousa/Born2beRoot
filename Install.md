# Install

Guide to install the **Debian** version of the project.

Install [**VirtualBox v6.1**](https://www.virtualbox.org/wiki/Downloads).

Download the [**Debian**](https://www.debian.org/download) image.

## Virtual Machine Settings

Launch **VirtualBox** and follow the create wizard:

1.  Create a new Virtual Machine
2.  Name: **Born2beRoot** \
    Type: **Linux** \
    Version: **Debian (64-bit)**
3.  1GB RAM (or more)
4.  Choose **Create Virtual Hard Disk**
5.  Choose **VDI**
6.  Choose **Dynamically allocated**
7.  8GB HD

Additional configuration via **Settings**:

1.  Select the **Storage** tab
2.  Select the IDE Controller Empty disk
3.  Select the CD icon and pick the Debian Image file `debian-xx-x-x-amd64-netinst.iso`

## Debian Installation

Run the virtual machine and follow the OS install wizard.

1.  `Install` (Not `Graphical install`) \
2.  Select Language and Locations and keyboard layout
3.  Hostname: **msousa42** \
    Domain name: **N/A** \
    Root password: ... \
    Re-enter: ... \
    Full name: **Manuel Sousa** \
    Username: **msousa** \
    Password: ... \
    Time zone: ...

### Partition setup

For bonus part:

1.  Partition method: **Manual**
2.  `SCSIX (0,0,0) (sda) -> 8.6 GB ATA VBOX HARDDISK`
3.  Create new empty partition table on this device? **Yes**
4.  `pri/log 8.6 GB FREE SPACE`
5.  Create a new partition \
    500M \
    Primary \
    Beginning \
    Mount point \
    `/boot` \
    Done setting up the partition
6.  `pri/log 8.1 GB FREE SPACE`
7.  Create a new partition \
    8.1GB or "max" \
    Logical \
    Mount point \
    Do not mount it \
    Done setting up the partition
8.  Configure encrypted volumes \
    Write the changes to disk and configure encrypted volumes? **Yes** \
    Create encrypted volumes \
    `/dev/sda5` \
    Finish \
    Really erase the data? **Yes** \
9.  Encryption passphrase
10. Configure the Logical Volume Manager \
    Write the changes to disk and configure encrypted volumes? **Yes** \
    Create volume group \
    **LVMGroup** \
    `/dev/mapper/sda5_crypt`
11. Create logical volume - **LVMGroup** - `root` - 2G
12. Create logical volume - **LVMGroup** - `swap` - 1G
13. Create logical volume - **LVMGroup** - `home` - 1G
14. Create logical volume - **LVMGroup** - `var` - 1G
15. Create logical volume - **LVMGroup** - `srv` - 1G
16. Create logical volume - **LVMGroup** - `tmp` - 1G
17. Create logical volume - **LVMGroup** - `var-log` - Remaining
18. `home #1 ...` \
    Use as: **EXT4 journaling file system** \
    Mount point: `/home` \
    Done setting up the partition
19. `root #1 ...` \
    Use as: **EXT4 journaling file system** \
    Mount point: `/` \
    Done setting up the partition
20. `srv #1 ...` \
    Use as: **EXT4 journaling file system** \
    Mount point: `/srv` \
    Done setting up the partition
21. `swap #1 ...` \
    Use as: **swap area** \
    Done setting up the partition
22. `tmp #1 ...` \
    Use as: **EXT4 journaling file system** \
    Mount point: `/tmp` \
    Done setting up the partition
23. `var #1 ...` \
    Use as: **EXT4 journaling file system** \
    Mount point: `/var` \
    Done setting up the partition
24. `var-log #1 ...` \
    Use as: **EXT4 journaling file system** \
    Mount point: \
    Enter manually \
    `/var/log` \
    Done setting up the partition
25. Finish partitioning and write changes to disk? **Yes**

### Final Steps

Scan another CD or DVD? **NO**

Debian archive mirror country: **Belgium**

`deb.debian.org`

Leave proxy info field empty.

Participate in the package usage survey? **NO**

Unselect SSH server & standart system utilities

GRUB **YES**

Device for boot loader instal
lation: `/dev/sda`
