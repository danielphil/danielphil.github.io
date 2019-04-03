---
title:  "Edinburgh Bus Tracker"
image:
    path: /images/900x1_transparent.png
    thumbnail: /images/bustracker/bustracker_mac_400x200.png
comments: false
---

There are a number of phone apps that can be used for checking arrival times for [Lothian Buses](https://www.lothianbuses.com) that make use of the [mybustracker API](http://www.mybustracker.co.uk/?page=API%20Key). However, I wanted to be able to see the times from my PC at work without constantly prodding at my phone. I figured I'd write a simple desktop app for this.

Users enter the code for bus stops and then select from a list of added stops to see when the next buses are arriving. The application automatically refreshes every minute. It's very basic, but did the trick for what I needed.  Prebuilt versions are available on [GitHub](https://github.com/danielphil/busalert/releases) if you'd like to try it out.

| Mac OS X | Windows |
|==========|=========|
|<img src="/images/bustracker/bustracker_mac.png">|<img src="/images/bustracker/bustracker_windows.png">|

Development
=========

The application was developed in C++ using [Qt 5.3](https://www.qt.io). I used the older Qt Widgets toolkit to get cross platform UI instead of QML to allow me to put something together quickly. Qt included good support for making HTTP requests (including support for HTTP proxies) to fetch the data from the API, JSON parsing and storing of cache data and user preferences. I even found that I was able to make use of lambdas and `std::function` to avoid some of the need to use signals and slots directly. However, this being C++, there were a few places where object ownership became confusing and it took some work to figure out the right place to `delete` objects.

The application was mostly developed on Mac OS X using Qt Creator, but it ported across to Windows with very little work and uses the same codebase. It looks very similar between the two platforms and also automatically switches to use  correct conventions, such as preference file storage locations, automatically.

After building on OS X, unnecessary Qt components are removed and the application is packaged into a disk image using the `macdeployqt` tool. On Windows, `windeployqt` is used to reduce DLL dependencies and Inno Setup is used to create an installer for the application that will also install the Visual Studio 2013 Redistributable automatically.

Source code and more information can be found on the [project GitHub page](https://github.com/danielphil/busalert).