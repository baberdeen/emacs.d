(defun plist-to-alist (the-plist)
  (defsubst get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
    alist))

(setq load-path (cons "~/.emacs.d/personal/base-packages/" load-path))
(setq-default indent-tabs-mode nil)

(load "byte-code-cache")
(     load "safe-load"         nil t )  ; error trapping load function.
(safe-load "my-site-start"     nil 2 )  ; load automatic site lisp loader

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; load all startup files

(my-site-start "~/.emacs.d/personal/site-start/")

(eval-after-load "dired"
  '(require 'dired-x))

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-added ((t (:background "#ddffdd" :foreground "white"))))
 '(magit-diff-added-highlight ((t (:background "#cceecc" :foreground "magenta")))))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(add-hook 'hs-minor-mode-hook (lambda () (define-key hs-minor-mode-map (kbd "<deletechar>") 'hs-toggle-hiding)))
