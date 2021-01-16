# mIRC-URL-Recognizer
A script for identifying URL and protocol strings in the mIRC client for IRC

---

> Originally submitted to `mircscripts.org` back in 2004, and since updated until 2006.

mIRC offers a simple double-click to open URLs, unfortunately this requires the user to be protocol-specific, 
when they often omit the prefixes and just provide a top level domain.

This script allows for configured wildcards and regex matches to identify links and protocols.

By default, it'll let you click links such as `domain.com` or `domain.net`, but you could also add strings 
such as `://` to click any protocol address as well (for example `ftp://somesite.com` to instantly open an FTP link).

---

## Installation

- Extract all files to any directory.
- Open mIRC and type: `/load -rs <dir>\URL-Recog.mrc`

If you get prompted about running the script, please select "Yes".

Right-click and select "URL Reconizer" in the popup menu if you wish to alter the recognized patterns.

---

The script is licensed under GPL-2.0, although mIRC itself uses a proprietary license, and is trialware.

You are free to use this script as you see fit, but please do include appropriate crediting whenever applicable.
