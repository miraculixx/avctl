avctl
=====

Turn cam and mic on/off with a single command. 

avctl is a simple command line and MATE panel tool to control 
cam and microphone on Linux Mint MATE and other pulseaudio
systems.


## Usage

Enable all capture devices (cam and mic)

    $ avctl on

Disable all capture devices (cam and mic)

    $ avctl off

Toggle

    $ avctl toggle

## Installation

    $ make install

Your MATE main menu should now have two new menu items

    * mute micro and cam OFF
    * unmute micro and cam ON

This is the equivalent of calling `avctl off` and `avctl on` respectively.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details