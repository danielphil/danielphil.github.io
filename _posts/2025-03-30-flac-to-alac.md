---
title:  "Converting FLAC to ALAC on macOS"
categories: Tools
---

I've been looking for a way to batch convert [FLAC](https://en.wikipedia.org/wiki/FLAC) files to [ALAC](https://en.wikipedia.org/wiki/Apple_Lossless_Audio_Codec) (Apple Lossless) format easily on my Mac. I finally found a solution that does what I want: convert the file with equivalent quality and preserve metadata so I can drop the file right into the macOS Music app and play it.

## Setup
You'll need `ffmpeg` for this. If you don't have it already you can install with the steps below:
1. Start by installing [Homebrew](https://brew.sh).
2. Once you've got Homebrew installed, run `brew install ffmpeg`.
    * Once complete, open Terminal and enter `ffmpeg` to check the install. You should see a bunch of version information displayed in the terminal.

## Convert a single file
1. Open `Terminal` and `cd` to a directory containing a FLAC file.
2. Enter the command `ffmpeg -i input.flac -c:v copy -c:a alac output.m4a` in the terminal, replacing `input.flac` with your input filename and `output.m4a` with your output filename.
3. Run the command and wait. You should now have an output ALAC file!

## Batch convert
This is based on a tip from Reddit. This builds on the command above to convert all files in a directory. Open Terminal, `cd` to your directory of FLAC files and enter the lines below:
```bash
export IFS=$'\n'
for x in `ls *.flac`; do ffmpeg -i $x -c:v copy -c:a alac ${x%flac}m4a; done
```

After a bit of a wait, you should now an ALAC file for each of your FLAC files.

## Other notes
Interestingly, the macOS Music app won't touch FLAC files but they open absolutely fine in Quicktime Player on macOS Sequoia.

macOS Sequoia already ships with a tool that can convert from FLAC to ALAC: `afconvert`. I tried this out but it didn't work quite as well as `ffmpeg` on the first try. Firstly, it didn't preserve metadata so the output ALAC file was missing tags like artist and album. It also didn't automatically match the data format of the input file: 16-bit FLAC files were converted to 32-bit ALAC files by default. `ffmpeg` just did the right thing by default and handled the metadata.

Here's the command I used if you want to experiment with `afconvert`:
```bash
afconvert -v -f m4af -d alac input.flac output.m4a
```

I might just be missing the right options to get this to work, but `ffmpeg` made this much easier so I'm sticking with that for now.