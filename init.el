(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

(setq load-path (cons "~/.emacs.d/personal-packages/" load-path))

(defalias 'yes-or-no-p 'y-or-n-p)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
                  (next-win-buffer (window-buffer (next-window)))
                       (this-win-edges (window-edges (selected-window)))
                            (next-win-edges (window-edges (next-window)))
                                 (this-win-2nd (not (and (<= (car this-win-edges)
                                                              (car next-win-edges))
                                                              (<= (cadr this-win-edges)
                                                                   (cadr next-win-edges)))))
                                      (splitter
                                             (if (= (car this-win-edges)
                                                         (car (window-edges (next-window))))
                                                   'split-window-horizontally
                                               'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
            (funcall splitter)
              (if this-win-2nd (other-window 1))
                (set-window-buffer (selected-window) this-win-buffer)
                  (set-window-buffer (next-window) next-win-buffer)
                    (select-window first-win)
                      (if this-win-2nd (other-window 1))))))

(require 'yasnippet)                                                              
(yas-global-mode 1)


(defun locate-data-directory (srch) 
  "~/.emacs.d/Templates"
)

(require 'template)
(template-initialize)

(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-calm-forest )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode nil)
 '(diff-command "diff")
 '(diff-switches "-cebWB")
 '(ecb-options-version "2.40")
 '(kill-whole-line t)
 '(mark-even-if-inactive t)
 '(python-honour-comment-indentation t)
 '(scroll-bar-mode (quote right))
 '(transient-mark-mode 1)
 '(truncate-lines t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ignore unistering things in dired

(require 'dired-x)
(setq-default dired-omit-files-p t) ; this is buffer-local variable
(setq dired-omit-files "^\\.[^.]\\|\\.pdf$\\|\\.tex\\|\\.pyc$")

;; python mode

(setq py-install-directory "~/.emacs.d/personal-packages/python-mode")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)




