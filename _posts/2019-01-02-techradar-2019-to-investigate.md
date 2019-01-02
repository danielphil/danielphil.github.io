---
title:  "Thoughtworks Technology Radar Vol. 19: Notes"
categories: Coding
---
I spent a little time over the New Year catching up on some reading, giving me an opportunity to skim through the 2018 [ThoughtWorks Technology Radar](https://www.thoughtworks.com/radar) to get an overview of interesting developments in the field. Here are some of the things that caught my eye.

## [Apache PredictionIO](https://predictionio.apache.org)

From the site:
> Apache PredictionIO® is an open source Machine Learning Server built on top of a state-of-the-art open source stack for developers and data scientists to create predictive engines for any machine learning task.

## [Nameko](https://www.nameko.io)

A framework for building microservices using Python.

## [Visual Studio Live Share](https://visualstudio.microsoft.com/services/live-share/)

An extension for Visual Studio and Visual Studio Code that allows multiple users to collaboratively edit, debug and discuss code. It even includes audio calling! This looks like it would be fantastic for remote pairing, or perhaps pairing in general. Looks like it goes beyond simple screen sharing: editing happens in your own environment instead of having remote keyboard/mouse access to another system. Definitely need to give this a try to see what it's like.

## [Prettier](https://prettier.io)

Rather than a linter that highlights errors, Prettier reformats your code automatically to conform to its style convention. Writing code formatting guides is time consuming, and raising and fixing formatting in code reviews also takes time, so anything that can just automate the process away sounds really appealing. There's already support for quite a few languages including TypeScript, JavaScript, HTML and CSS.

This reminds me of another tool called [Black](https://github.com/ambv/black) that does a similar thing for Python code.

## [Mermaid](https://mermaidjs.github.io)

A tool for generating flowcharts, Gantt charts and sequence diagrams from a textual description. I'm always interested in tools like this: it's easy to write text and store it in version control with formats like Markdown, but diagrams often require the use of another program that saves the data in a binary file and then requires an export to embed the rendered diagram into the final document.

(I should add that this is less of an issue now since I've stared using Confluence with Gliffy as it allows diagrams to be edited directly on the page. Still useful to know what else is out there though!)

## ["Distroless" Docker Images](https://github.com/GoogleContainerTools/distroless)

> "Distroless" images contain only your application and its runtime dependencies. They do not contain package managers, shells or any other programs you would expect to find in a standard Linux distribution.

## [Data Version Control (DVC)](https://dvc.org)

A version control system for machine learning projects. Allows storage of code, models, data and metrics in one place. Looks like it builds upon Git too, so might not be a big jump to adopt.