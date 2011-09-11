;;;
;;; template file stuff
;;;

;; make templates go underneath ~/.emacs.d
;; so everything is useable as scm project 
;; so it can easily be pulled

(defun locate-data-directory (srch) 
  "~/.emacs.d/personal/Templates"
)

(require 'template)
(template-initialize)

