---
title:  "Getting started with Ollama"
categories: LLM
---

In a [previous post](../running-local-llms/), I'd experimented with running LLMs locally using [llama.cpp](https://github.com/ggml-org/llama.cpp) on a Windows machine with a GPU. It worked well, but the process took quite a few steps to set things up. Since then, I found [Ollama](https://ollama.com) and tried it out on a Macbook Pro (M4 Pro).

I learned two things: Ollama makes it really easy to experiment with running an LLM locally and running local LLM inference on the M4 Pro GPU chip is actually usable!

Here's the steps if you want to experiment for yourself on a Mac. I'm assuming that you've already got [Homebrew](https://brew.sh) installed to make installation easier.

1. Start by installing Ollama with `brew install ollama`.
2. Start the Ollama server with `ollama serve`. Leave it running in the background and open a new Terminal tab.
3. Enter `ollama run llama3.1` in your new Terminal tab. This will pull down llama3.1 and then launch an interactive prompt where you can start a conversation with the model.
4. When you're done, enter `/bye` to terminate the chat. You can now `Ctrl+C` the running server to shut down Ollama.

It's great how easy this makes getting started with local LLMs! There's a bunch of other models in the [Ollama library](https://ollama.com/search) if you want to experiment with different models. For example, you can try out DeepSeek-R1 with `ollama run deepseek-r1`.