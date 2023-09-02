---
title:  "Steam Deck setup"
categories: SteamDeck
---

I caved and finally bought a Steam Deck. The internet was full of guides to upgrade and modify it so I'm documenting some of the things I've tried here.

SSD replacement
===============

I bought the 64GB model as it seemed it would be reasonably easy to open the system and then replace the M.2 2230 SSD with a new one. Following the [iFixit guide](https://www.ifixit.com/Guide/Steam+Deck+SSD+Replacement/148989) was mostly straightforward, but there's a few things worth noting.

The screws on the back of the system seem to be Phillips #1 heads. If you're having trouble getting into the system, a small flathead screwdriver also works. I had to use this for the two long screws at the bottom of the system as the PH1 driver I had was too wide for the recessed screws.

My [new SSD](https://www.amazon.co.uk/Corsair-MP600-MINI-NVMe-PCIe/dp/B0C28HLKNB) was a little thicker than the old one so I had to open the foil wrapper and rewrap it around the new drive.

Take care to route the fan cable around the side of the shield when putting things back together as there's a number of thin wires to watch out for. There's also a small notch on the shield that goes into a hole on the mainboard so make sure you align the shield properly when putting it back.

Once you've put everything back together you must connect the charger to the Steam Deck before it'll switch back on from battery storage mode.

Building the recovery image
===========================

I used a 32GB USB flash drive for this. It's USB 2.0 which made the process really slow, so worth using a faster drive if you have one.

The restore image can be obtained from Valve's [Steam Deck restore instructions](https://help.steampowered.com/en/faqs/view/1b71-edf2-eb6d-2bb3). Rather than using Balena Etcher I just followed the Linux instructions on my Mac. There were some slight differences in the commands here.

Plug in your USB drive and then run `diskutil list` to get a list of all drives on your system. The output will contain a section that looks like this:
```
/dev/disk4 (external, physical):
   #:                       TYPE NAME         SIZE       IDENTIFIER
   0:      GUID_partition_scheme              *32.0 GB   disk4
   1:                        EFI esp           67.1 MB   disk4s1
   2:       Microsoft Basic Data efi           134.2 MB  disk4s2
   3: 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709     5.4 GB    disk4s3
   4: 4D21B016-B534-45C2-A9FB-5C16E091FD2D     268.4 MB  disk4s4
   5: 933AC7E1-2EB4-4F13-B844-0E14E2AEF915     1.8 GB    disk4s5
```
Make a note of the disk number. On my system, the USB drive is `disk4`.

Unmount your USB drive (updating disk number as appropriate).
```bash
diskutil unmountDisk disk4
```

Finally, erase your USB drive and replace the contents with the recovery image using the command below. Replace `rdisk4` with the correct number for your drive.
```bash
bzcat steamdeck-recovery-4.img.bz2 | sudo dd if=/dev/stdin of=/dev/rdisk4 oflag=sync status=progress bs=128M
```
Note: I first tried this with `disk4` instead of `rdisk4` and it was much slower. It's still pretty slow with my cheap USB 2.0 drive, but not using `rdisk` made it much worse!

Final step, unmount your USB drive again and then you can plug it into the Steam Deck.
```bash
diskutil unmountDisk disk4
```

Partition editing for installing Windows
========================================

To get GParted onto a USB stick, start by downloading the [GParted live image ISO for AMD64](https://gparted.org/download.php).

Use the same diskutil commands above to check your USB drive number and unmount the drive.

Finally, wipe the USB drive contents and replace it with the GParted Live CD using the command below.
```bash
sudo dd if=gparted-live-1.5.0-1-amd64.iso of=/dev/rdisk4 oflag=sync status=progress bs=4M
```

Unmount, and then you can plug the drive into the Steam Deck.

Getting Windows onto the USB drive
==================================

I ended up using the Windows installation media creation tool here. First attempt was to download the Windows ISO and then use dd to copy it to the USB stick, but installation wouldn't start due to a lack of drivers. It worked fine once I used the installation media creation tool to copy to the USB stick.

Getting back to Steam OS
================
The Steam Deck will always boot into Windows once installed. You can manually select Steam OS through boot menu but you'll have to do this each time you restart. If that's annoying, there's a [small script](https://github.com/scawp/Steam-Deck.Force-SteamOS-On-Boot) you can install that'll make the Steam OS selection stick between reboots.

Completely erasing the SSD
==========================
If you need to completely erase the internal SSD, you can boot an Ubuntu live image over USB and use the `nvme` command to wipe the drive. This is from [this](https://askubuntu.com/questions/1310338/how-to-secure-erase-a-nvme-ssd) Stack Overflow post.

```
sudo apt install nvme-cli
nvme help
nvme --help
nvme --help format
sudo nvme list
sudo nvme format -s1 <device>

    fred@z170-focal-k:/mnt/data$ sudo nvme list
[sudo] password for fred: 
Node             SN                   Model                                    Namespace Usage                      Format           FW Rev  
---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme0n1     S4P2NF0M514514L      Samsung SSD 970 EVO Plus 500GB 
```