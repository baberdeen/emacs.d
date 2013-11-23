This global minor mode highlights escape sequences in strings and
other kinds of literals with `font-lock-regexp-grouping-backslash'
face when appropriate.

It currently supports `ruby-mode' and both main JavaScript modes.

To enable it elsewhere, customize `hes-simple-modes'.

Put this in the init file:

(hes-mode)
