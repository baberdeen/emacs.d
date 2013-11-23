To install, put code like

  (require 'scratch-palette)

in your .emacs file. You can display and edit scratch note for the
currently-editing file, with "M-x scratch-palette-popup". If there's
no scratch notes yet, a new scratch note is created. Scratch note is
is hidden when pressed "C-g", "C-x C-s" or "C-x C-k", saving contents.
All scratch notes are stored in scratch-palette-directory. You can also
change the directory with code like

  (setq scratch-palette-directory "~/.emacs.d/palette/")
