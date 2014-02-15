---
layout: post
title:  "Making ISO Disc Images on Mac OS X"
categories: osx
---

Was creating some disc images this week and found the following commands handy on OS X. I've only tried this with OS X Lion, but the instructions should probably apply to other versions of the OS too.

Making an ISO
=============

Use Disk Utility to find the path to your CD drive (in my case /dev/disk1) and then open a Terminal and type the following to create an ISO image of the disc in the drive:
{% highlight sh %}
dd if=/dev/disk1 of=your_iso_name.iso
{% endhighlight %}

To monitor progress while dd is silently working, run the following in another Terminal window:
{% highlight sh %}
while :; do clear; ls -l your_iso_name.iso; sleep 2; done
{% endhighlight %}

Verifying the ISO
=================

If you want to be super paranoid about things, you can verify your ISO with the following commands:
{% highlight sh %}
openssl sha1 /dev/disk1
openssl sha1 your_iso_name.iso
{% endhighlight %}

Once the commands have finished, compare the output hashes to check that they match. If they do, then your ISO should be fine.