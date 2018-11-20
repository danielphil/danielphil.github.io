---
title:  "Talk notes from Scottish Developers event"
categories: Notes
---

Today I attended a [series of talks](https://www.eventbrite.co.uk/e/triple-bill-webpack-ios-app-using-xamarin-devops-tickets-21081493314) at the Microsoft offices in Edinburgh organised by [Scottish Developers](http://scottishdevelopers.com). Here are my *hastily scribbled* notes from the talks.

# Overview

The speakers were the organisers of the upcoming [Techorama](http://www.techorama.be) conference in Belguim, so the session started with an advert for the conference.

# Webpack: handle your JavaScript dependencies with Style
*Kevin DeRudder*

Talk on using [Webpack](https://webpack.github.io) to manage resource dependencies.

Started with a simple example of JavaScript injection into a page by creating a script tag, setting the source to the location of the JavaScript and then adding the tag to the DOM.

Talk focussed on the idea of concatenation of resources as well as managing dependencies between files. There was a quick overview of some other solutions:

* [Browserify](http://www.techorama.be)
* [require.js](http://requirejs.org)
* [Gulp](http://gulpjs.com)/[Grunt](http://gruntjs.com)

Main drawback of these solutions was that they didn't 'intelligently' include only the dependencies that are required like Webpack and some of them only package JavaScript, whereas Webpack can include css, images, JS and more.

As well as packaging, Webpack can also run plugins. ES6 can be converted to ES5 as part of the Webpack build process using a [Babel](https://babeljs.io) plugin. Plugins also exist for [React](https://facebook.github.io/react/).

There was an example given in which some ECMAScript 6 features were shown:

* [Backtick string substitution](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals)
* [import](https://developer.mozilla.org/en/docs/web/javascript/reference/statements/import)
* [const](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const)
* [Default parameters](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Functions/default_parameters)
* [Promises](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Promise)
* [Block scoping with `let`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/let)

A more advanced demo was shown at the end where [Mansonry](http://masonry.desandro.com) was used to get a [Pinterest](https://www.pinterest.com) style layout.

# Building your first real-world iOS app using Xamarin in 60 minutes
*Gill Cleeren*

An example of using [Xamarin](https://xamarin.com) to build an iOS application. Most of the talk was an overview of an existing application the speaker had created, rather than a new application being developed from scratch.

Xamarin allows you to write an iOS application in C# instead of having to use Objective-C or Swift to access iOS APIs. Applications are provided with .NET core functionality (collections, networking, base types, etc.) and a C# wrapper layer around the iOS APIs to make them usable from C#. Doesn't try to abstract away from iOS layer and provide a cross-platform toolkit for UI. Expectation is that UI code will be rewritten for other platforms like Android, but core application logic can be shared. Exposes lots of iOS concepts (delegates, view controllers, etc.) to the developer so recommended reading up on iOS development before using.

Applications are compiled to native ARM code instead of IL running on the CLR. Garbage collection is handled in the runtime that is built into the application.

It's possible to develop the application on Windows using Visual Studio, but a Mac is needed for testing and deployment. Xamarin Studio is available for development on the Mac. Seems to provide UI editing tools similar to Xcode.

It's a commercial product that comes with a licence fee, but this may be changing as Microsoft has purchased it.

Also supports development for Android, Windows Phone, OS X and Windows. 

# DevOps with Visual Studio Release Management
*Pieter Gheysen*

Talk about using [Visual Studio Team Services](https://www.visualstudio.com/en-us/products/visual-studio-team-services-vs.aspx). Described as TFS in the cloud. Free for teams up to 5 people. Used to be called Visual Studio Online.

Provides:

* Source control using Git
* Hosted Windows build server
  * Builds with Visual Studio in the cloud
* Publishing build artefacts
* Separated 'build system' and 'release system'

Can use [PowerShell Desired State Configuration](https://msdn.microsoft.com/en-us/powershell/dsc/overview) to automatically configure a VM through a configuration file. For example, automatically install IIS.

[SQL Server Data Tools](https://msdn.microsoft.com/en-us/library/hh272686(v=vs.103).aspx) can be used to 'keep your database in version control'. Not sure if this refers to the schema- was just mentioned in passing.

VSTS includes the concept of *release management* separate from the build process. Code changes go through a build process, then artefacts of the build can pass through one or more release steps. Release steps can involve more testing, deployment, publishing or additional scripts. Separate VM configurations can be used for each stage of the user-defined release processes. Recommendation is that the build process should produce a generic package that can be customised for each step of the release process. Environment configuration should be a separate step that happens during the release process.
