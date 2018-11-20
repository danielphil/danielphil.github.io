---
title:  "Setting up Jekyll for building GitHub pages"
categories: Notes
---

Time to resurrect the old GitHub Pages site! I haven't really touched this for the last two years, so it's time I brought the site up to date. One part of this is installing Jekyll locally on my Mac so I can test the site without continually uploading it to GitHub.

# Installing Jekyll

I followed the [setup instructions](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/) on GitHub to get everything running, but it wouldn't install properly. Instead, I:
1. Installed [Homebrew](https://brew.sh).
2. Added the contents below to `~/.bash_profile` and then reloaded my profile with `source ~/.bash_profile`:
    ```
    export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.5.0/bin/:$PATH"
    export LDFLAGS="-L/usr/local/opt/ruby/lib"
    export CPPFLAGS="-I/usr/local/opt/ruby/include"
    ```
3. Cross fingers and... `gem install bundler`
4. Set up the Gemfile and install dependencies bundle (as detailed on the GitHub instructions).
5. `cd` into your GitHub pages clone and `bundle exec jekyll serve`.

The process has become significantly easier since GitHub introduced remote themes. I thought I might have to spend a bunch of time redesigning the site, but [this theme](https://github.com/mmistakes/so-simple-theme) was much nicer than anything I could've tried to quickly put together.