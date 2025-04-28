
# hydotfiles

## what is this repo

As the name suggests, this is my fork of the great [HyDE](https://github.com/HyDE-Project) Project dotfiles.

> [!CAUTION]
> These dotfiles are heavily personalized. Do **not** install them on your system unless you [know what you are doing.](hydotfiles.wiki/Guide.md)
> You have been warned.

## Installation

run the following commands:
```
git clone https://github.con/schmynth/hydotfiles
cd hydotfiles/
install.sh
```

## why is it public


> [!TIP]
> If you don't know what you're doing, the [wiki](https://github.com/schmynth/hydotfiles/wiki) of this repo might help. 
> It is a work in progress but does try to explain, how these and by extension the HyDE dotfiles work.
> Especially the [guide](https://github.com/schmynth/hydotfiles/wiki/Guide) goes into detail regarding the installed files, scripts and configuration.

Because I was fascinated by the Project HyDE dotfiles I decided to analyse their inner workings in order to:
- understand how they work
- understand how I can tweak them to make them my own
- check if they are safe to install and use

## what does this repo have that upstream does not

I added a few convenience scripts that help me. For example, there is a ```realtime_audio.sh``` script in ```install_scripts``` that tweaks the OS for professional audio as suggested in the [Arch Wiki](https://wiki.archlinux.org/title/Professional_audio).
I added a .desktop file for Bitwig Studio that points to a script that sets the cpu frequency governor to performance when starting and powersave when exiting Bitwig automatically.
This could easily be edited to work with any daw.

## who might be interested

If you, like me, are using Bitwig to make music on Arch Linux and like Project HyDE dotfiles, this repo might be for you.
