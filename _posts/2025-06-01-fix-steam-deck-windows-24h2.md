---
title:  "Fixing Steam Deck dual boot after installing Windows 11 24H2 update"
categories: SteamDeck
---

I rarely boot into Windows 11 on my Steam Deck so each boot often comes with a slew of Windows updates to install. Yesterday's update was no different and brought the Windows 11 24H2 update along. Everything worked fine post-update when running Windows but Steam OS would no longer boot: I was presented with a Steam Deck logo on startup and then the boot process would freeze.

After some investigation, it turns out that the Windows update broke the partition configuration. Here's what it took to fix:

1. Creating a [Steam recovery USB stick](https://help.steampowered.com/en/faqs/view/1B71-EDF2-EB6D-2BB3) and booting the Steam Deck using the stick.
2. Opening the console and running `lsblk`. The list will be empty when the partition setup is broken.
3. Run `sudo fdisk /dev/nvme0n1`. It should print an error in red mentioning that the primary GPT table is corrupt.
4. Enter `p` to print the partition table. You should now have a list of partitions.
5. Enter `w` to write the fixed partition table.
6. Quit `fdisk` and confirm the fix with `lsblk`.
7. Shut down the Steam Deck and then use the boot manager to select Steam OS. It should now boot!

Thanks to [this blog post](https://blog.lazerwalker.com/2024/10/23/dual-booting-steam-deck.html) for providing the instructions to fix this.

There's more Steam Deck setup steps in [my other guide here](/steamdeck/steam-deck-setup/).