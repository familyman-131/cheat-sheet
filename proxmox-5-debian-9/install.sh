#!/bin/bash
# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Stretch

apt install -y aptitude mc htop iotop sysstat nload lshw 
###
echo "# IPv6 disabled
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
###
echo "deb http://download.proxmox.com/debian/pve stretch pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
###
wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
###
apt update && apt dist-upgrade -y
###
aptitude  install -y proxmox-ve postfix open-iscsi
###
apt remove -y  os-prober
###

# to add real HDD to VM
# see "product" "serial"
# $ lshw -class disk -class storage
# check it with /dev/"disk"
# $ ls -l /dev/disk/by-id/ata\sata-"product"
# add it to VM
# $ qm set 100 -virtio1  -virtio1 /dev/disk/by-id/ata\sata-"product"
# check it in VM.conf
# or manually add 
# $ sfdisk -l -s - shows size in Kb
# and make row like this
# virtio1: /dev/disk/by-id/ata-WDC_WD5000AAKX-603CA0_WD-WMAYUV041558,size=488386584K

# Bug 1377155 - "HID Button over Interrupt Driver" not working properly in windows10 and win2016
#Device manager -> Right click HID Button over Interrupt Driver -> Click Update Driver Software...
#Click "Browse my computer for driver software"
#Click "Let me pick from a list of device drivers on my computer"
#Select "Generic Bus" and click Next.
########OR###########
#According to MS the solution is to remove the device:
#1. Uninstall the existed driver package for this device, if can check delete button, please check it too.
#2. Download the PsTools from
#https://technet.microsoft.com/en-us/sysinternals/pstools.aspx
#3. Unzip PsTools, and locate the folder of PsTools, then input in CMD (Run as Administrator):
#psexec -s -i regedit.exe
#4. Delete subkey ACPI0010 under HKLM\SYSTEM\DriverDataBase\DriverPackage\hiinterrupt.inf_x86_<some instance ID>\Descriptors\ACPI0010
#And delete subkey "bidinterrupt.inf" under HKLM\SYSTEM\DriverDataBase\DeviceIds\ACPI\ACPI0010
#5. Rescan device to see the effect.

# https://pve.proxmox.com/wiki/HTTPS_Certificate_Configuration_(Version_4.x_and_newer)
# 
# ./acme.sh --issue --standalone --force --keypath /etc/pve/local/pve-ssl.key --fullchainpath /etc/pve/local/pve-ssl.pem --capath /etc/pve/pve-root-ca.pem --reloadcmd "systemctl restart pveproxy" -d prox1.it-man.pro
#(local is symlink, so may be you need fullpath to /etc/pve/nodes/NODE_NAME)
#
# crontab
#  "/root/.acme.sh"/acme.sh --cron --force --home "/root/.acme.sh"
# 
#normally result must be as:
#[Sun Mar 26 19:10:38 EEST 2017] Your cert is in  /root/.acme.sh/prox1.it-man.pro/prox1.it-man.pro.cer
#[Sun Mar 26 19:10:38 EEST 2017] Your cert key is in  /root/.acme.sh/prox1.it-man.pro/prox1.it-man.pro.key
#[Sun Mar 26 19:10:38 EEST 2017] The intermediate CA cert is in  /root/.acme.sh/prox1.it-man.pro/ca.cer
#[Sun Mar 26 19:10:38 EEST 2017] And the full chain certs is there:  /root/.acme.sh/prox1.it-man.pro/fullchain.cer
#[Sun Mar 26 19:10:38 EEST 2017] Installing CA to:/etc/pve/pve-root-ca.pem
#[Sun Mar 26 19:10:38 EEST 2017] Installing key to:/etc/pve/local/pve-ssl.key
#[Sun Mar 26 19:10:38 EEST 2017] Installing full chain to:/etc/pve/local/pve-ssl.pem
#[Sun Mar 26 19:10:38 EEST 2017] Run reload cmd: systemctl restart pveproxy
#[Sun Mar 26 19:10:40 EEST 2017] Reload success

