(setq load-path (cons "~/.emacs.d/personal/base-packages/" load-path))

(     load "safe-load"         nil t )  ; error trapping load function.
(safe-load "my-site-start"     nil 2 )  ; load automatic site lisp loader

;; load all startup files

(my-site-start "~/.emacs.d/personal/site-start/")




