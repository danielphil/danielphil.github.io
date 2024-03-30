---
title:  "Running Large Language Models locally"
categories: LLM
---

The easiest way to get started with Large Language Models (LLMs) like GPT-4 is to use the [OpenAI API](https://openai.com/product) or [Azure OpenAI](https://azure.microsoft.com/en-us/products/ai-services/openai-service). However, since the LLaMA leak a variety of LLMs have been created that can be hosted locally. I was interested to see what it would take to do this and what tools are available.

Tools
=========

One of the the main pieces of software used to execute local LLMs is [llama.cpp](https://github.com/ggerganov/llama.cpp). Models can be executed on a variety of hardware such as CPU-only, GPU and Apple silicon. It can be used directly but chances are that any piece of software that supports local LLMs already integrates it.

A great sandbox environment that provides a web chat interface along with easy access to parameters for executing the model is [Text generation web UI](https://github.com/oobabooga/text-generation-webui).

Both llama.cpp and Text generation web UI can expose an OpenAI API compatible endpoint, making it trivial to integrate with existing libraries that expect to use OpenAI models. Simply change the endpoint URL to point to your local server instead.

Finally, you'll need some models if you want to run locally. There's a huge collection available from [TheBloke on HuggingFace](https://huggingface.co/TheBloke).

Setting up on Windows
=====================

First thing you'll need to install is Python 3.11. Check that you can run `python --version` after installation.

### GPU prerequisites

GPU inference makes things **much** faster, so this is the recommended way to go if you have an NVIDIA GPU. There's some setup you'll have to do first though so that you can build `llama-cpp-python` with GPU support.

1. Install Visual Studio (the full edition, rather than VS Code) and select `C++ core features`, `C++ CMake Tools for Windows`, and either the `Windows 10` or `Windows 11` SDK.
2. Download and install the [CUDA Toolkit](https://developer.nvidia.com/cuda-12-2-0-download-archive?target_os=Windows) from NVIDIA.
3. Verify the installation with `nvcc --version` and `nvidia-smi`. Both these commands should work.
4. Add `CUDA_PATH` to your environment variables (if you don't have it already). It should look like this `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.2`.

### Setting up Text generation web UI

For this example, I've started with Text generation web UI. Here's the steps to set it up with Powershell:
```PowerShell
# get the basic repo cloned and set up
git clone https://github.com/oobabooga/text-generation-webui.git
cd text-generation-webui
python -m venv env
.\env\Scripts\activate
pip install -r requirements.txt

# additional steps for GPU users
pip uninstall -y llama-cpp-python
$env:CMAKE_ARGS = "-DLLAMA_CUBLAS=ON"
$env:FORCE_CMAKE = 1
# The build step here should be running nvcc.exe for CUDA compilation
pip install llama-cpp-python --no-cache-dir --verbose
```

### Downloading a model

Download [llama-2-7b-chat.Q5_K_M.gguf](https://huggingface.co/TheBloke/Llama-2-7B-chat-GGUF/resolve/main/llama-2-7b-chat.Q5_K_M.gguf) and put the file in the `models` subdirectory of `text-generation-webui`. This was the model I found worked well on an 8GB GPU.

I found that I needed to use GGUF format models for llama.cpp to work.

### Running it!

You're now ready to start the UI. Run `python server.py --listen --chat --n-gpu-layers 200000 --model llama-2-7b-chat.Q5_K_M.gguf` to launch the server. You should now be able to access the server on [http://localhost:7860/](http://localhost:7860/). This will also expose the server to your network so you can connect from other computers.