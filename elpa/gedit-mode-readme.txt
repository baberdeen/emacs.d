INTRODUCTION


What's this?

It is a minor mode for Emacs. It aims to tame Emacs' archaic
default keybindings and make them more accessible to novice users.
Although titled "GEdit" mode, users of every graphical application
ever written should find most of these keybindings familiar. GEdit
was simply chosen as the namesake since that is what I was
primarily using before I discovered Emacs.

Why don't you just use GEdit if you like it so much?

Listen buddy, I don't like your attitude!

Seriously though, once I had a taste of Elisp, I was totally hooked
on Emacs. I actually tried to reimplement some basic Emacs features
as Python plugins inside GEdit, but gave up when I discovered that
a 10-line whitespace-stripping elisp snippet required 100 lines of
Python code to implement in GEdit.

So, if you are a vetern Emacs ninja, this mode may be of little
interest to you. But if you are just starting out and you find the
default keybindings intimidating, then I encourage you to give this
a try.

USAGE

gedit-mode is now hosted on MELPA! Type `M-x package-install
gedit-mode`, then add the following code to your init file:

    (require 'gedit-mode)
    (global-gedit-mode)

For the complete experience, you'll want sr-speedbar, shell-pop,
and tabbar packages. I've listed those as requirements above,
although the code I've written here is smart enough not to explode
if they're missing. I also personally recommend visual-regexp and
ace-jump-mode, although those have nothing to do with GEdit ;-)

TODO

At this point, I believe that I have defined a highly accurate
reproduction of all of GEdit's default keybindings, at least
according to GEdit's official documentation. If there is anything
missing here, it is likely undocumented, but please do let me know
about it.

I still need:

* to think up some sensible new bindings for all the stuff that
  I've clobbered here.

* to clean up some of the sr-speedbar and shell-pop config code,
  particularly allowing those settings to be reverted when
  gedit-mode is disabled.

For more information

https://help.gnome.org/users/gedit/stable/gedit-shortcut-keys.html.en
