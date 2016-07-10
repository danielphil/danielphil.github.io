---
layout: post
title:  "Using three.js with TypeScript"
categories: three.js typescript bower typings
---

I tend to modify more projects than I create, so while I can often remember APIs, I often forget the steps I used to set everything up. Therefore, this page is a future reference for me when I forgot to do all this. (If you haven't done this before then hopefully this will serve as a good starting point!)

I've been using [TypeScript](http://www.typescriptlang.org) for some of the [three.js](http://threejs.org) projects that I've been working on. TypeScript has helped me catch a load of errors at compile time that would've resulted in tedious debugging to figure out why things aren't working. However, to get all the benefits of TypeScript, there's some setup you'll want to do first.

# Getting TypeScript

The TypeScript compiler requires [node.js](https://nodejs.org/), so install that first if you don't already have it. Then install the TypeScript compiler:
{% highlight bash %}
sudo npm install -g typescript
{% endhighlight %}

If all goes well, you should be able to run the compiler from the command line by typing `tsc`.

I recommend installing a TypeScript aware editor. I've mostly been using [Visual Studio Code](https://code.visualstudio.com/), but there's plugins available for many other editors too.

# Getting Typings

You can use three.js without TypeScript type definitions, but you miss a lot of the benefits of the language if you do this. In the past, there was a tool called [DefinitelyTyped](http://definitelytyped.org) which aimed to provide a simple way of getting TypeScript type definitions, but this [has been deprecated](https://github.com/DefinitelyTyped/tsd/issues/269) and instead you should use [Typings](https://github.com/typings/typings).

{% highlight bash %}
sudo npm install typings --global
{% endhighlight %}

# Getting Bower

You can always install three.js by downloading it from the [official website](http://threejs.org) and just popping the `three.js` file in an appropriate location, but I've been experimenting with [Bower](https://bower.io) as a way to manage dependencies.

As with TypeScript, you'll need to already have node.js installed to use Bower. You can globally install it with:
{% highlight bash %}
npm install -g bower
{% endhighlight %}

# Setting everything up

Create a new directory, `cd` into it and:
{% highlight bash %}
bower init
{% endhighlight %}

Bower will ask you a number of questions, and when finished, will create `bower.json` in the current directory. This is the file Bower uses to track all the dependencies that you've installed. If you add this to your source repository, you'll be able to restore all the dependencies you need from a fresh clone by using `bower install`.

Install three.js using Bower with the command below. This will also update `bower.json` to include the dependency.
{% highlight bash %}
bower install threejs --save
{% endhighlight %}
(This can take quite a while, the three.js repository is biiiiig.)

Once done, three.js will be checked into the folder `bower_components`. Add this folder to your `.gitignore`. The actual three.js source file lives in `bower_components/three.js/build/three.js` or `bower_components/three.js/build/three.min.js` (depending on what you want to use).

Download the type definitions for three.js with:
{% highlight bash %}
typings install dt~three --global --save
{% endhighlight %}

Typings will create `typings.json` (add to source control) and a `typings` directory (add to `.gitignore`). If you need to install type definitions from a clean clone, you can reinstall with `typings install`.

# Testing it out

Done! To test it, create a `src` directory and make a file called `test.ts`. Put the following into the file:
{% highlight javascript %}
/// <reference path="../typings/index.d.ts" />
{% endhighlight %}

Now if you open the file up in your TypeScript editor, you should start getting autocompletion on the three.js types.

Finally, in your HTML, you can include the three.js script downloaded by Bower with:
{% highlight html %}
<script src="bower_components/three.js/build/three.js"></script>
{% endhighlight %}
