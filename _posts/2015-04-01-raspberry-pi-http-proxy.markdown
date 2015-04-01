---
layout: post
title:  "Setting up a Raspberry Pi as an HTTP proxy"
categories: raspberrypi http proxy
---

I needed an HTTP proxy for testing busalert today so my Raspberry Pi was temporarily turned into a proxy server. Here's the steps I needed to follow to get it to work.

## Install Squid

{% highlight bash %}
sudo apt-get update
sudo apt-get install squid3
{% endhighlight %}

## Edit Configuration

Open `/etc/squid3/squid.conf` in an editor and uncomment the following lines to make Squid accept connections:

{% endhighlight %}
#acl localnet src 192.168.0.0/16 # RFC1918 possible internal network
#http_access allow localnet
{% endhighlight %}

(You'll have to change these if your local network isn't 192.168.0.*)

## Restart Squid

{% highlight bash %}
sudo service squid3 restart
{% endhighlight %}

## Configure clients

Change the proxy settings for the client machine to use an HTTP and HTTPS proxy at the IP address of your Raspberry Pi on port 3128.

## Verifying the proxy is working

Use `sudo tail -f /var/log/squid3/access.log` to view the access log for Squid and check that your requests on the client are being routed through the proxy.
