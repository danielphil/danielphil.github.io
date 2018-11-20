---
title:  "Running Qt Creator on Windows with an Intel GMA 950 GPU"
categories: Notes
---

I set up a fresh install of Qt 5.4 on Windows 7 today and Qt Creator crashed on startup with an error in ig4icd32.dll. Some Google searches gave me the impression that it might be related to the Qt Creator Welcome page (which uses QtQuick) and my terrible old Intel GMA 950 GPU which I've got in this laptop.

To fix this, I opened C:\Qt\Qt5.4.0\Tools\QtCreator\share\qtcreator\QtProject\QtCreator.ini and edited it to include the following:

{% highlight ini %}
[Plugins]
Ignored=QmlProfiler, Valgrind, Welcome
{% endhighlight %}

This disables the welcome page plugin and allows Qt Creator to start without crashing.
