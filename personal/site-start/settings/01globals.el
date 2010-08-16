(global-set-key [(control x) (control b)] 'bs-show) ;; better buffer selector
(global-font-lock-mode t)                           ;; always want syntax highlighting
(setq font-lock-maximum-decoration t)               ;; as nice as possible
(xterm-mouse-mode)                                  ;; use mouse buttons
(mouse-wheel-mode)                                  ;; use mouse scroll weel
(transient-mark-mode 1)                             ;; region is highlighted
(show-paren-mode 1)                                 ;; show matching parenthesis
(setq-default truncate-lines t)                     ;; truncate lines if they are too long
(setq-default truncate-partial-width-windows nil)   ;; trucate even even when screen is split into multiple windows
(setq inhibit-startup-message t)                    ;; inhibit startup message
(fset 'yes-or-no-p 'y-or-n-p)                       ;; type "y"/"n" instead of "yes"/"no"
(setq kill-whole-line t)                            ;; C-k kills whole line and newline if at beginning of line
(setq scroll-conservatively 2)                      ;; scroll in small increments
(setq scroll-preserve-screen-position t)            ;; return to same line on a scroll back
(setq next-line-add-newlines nil)                   ;; do NOT add newlines if I cursor past last line in file


;; Saves a history of files opened previously (including other times 
;; Emacs was used - very useful)

(require `savehist)
(setq savehist-file "~/.emacs.d/history")
(setq savehist-length 1000)
(savehist-load)

;; Saves the position the cursor was in a file before the file was closed.

(load-library "saveplace")
(setq save-place-file "~/.emacs.d/places")
(setq shadow-todo-file "~/.emacs.d/shadow-todo")
(setq-default save-place t)

;; time-stamps  from http://www.djcbsoftware.nl/dot-emacs.html
;; when there is a "Time-stamp: <>" in the first 10 lines of the file,
;; emacs will write time-stamp information there when saving the file.
;; see the top of this file for an example... 

(setq 
  time-stamp-active t          ; do enable time-stamps
  time-stamp-line-limit 10     ; check first 10 buffer lines for Time-stamp: <>
  time-stamp-format "Last changed %02d-%B-%04y %02H:%02M:%02S by %L, %u") ; date format
(add-hook 'write-file-hooks 'time-stamp) ; update when saving


;;;
;;; Keep versioned backups
;;;

(setq version-control t                 ;; Use version numbers for backups
        kept-new-versions 16            ;; Number of newest versions to keep
        kept-old-versions 2             ;; Number of oldest versions to keep
        delete-old-versions t           ;; Ask to delete excess backup versions?
        backup-by-copying-when-linked t ;; Copy linked files, don't rename.
        backup-directory-alist          ;; backup files go into ~/.saves
          '(("." . "~/.emacs.d/saves")) 
        )

(defun force-backup-of-buffer ()        ;; backup a buffer now
    (let ((buffer-backed-up nil))
      (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer) ;;; backup buffer on save

;;
;; toggle window split between hotizontal and vertical

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

(global-set-key [(control x) (t)] 'toggle-window-split)

;;
;; other stuff
;;

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; default to unified diffs
(setq diff-switches "-u")

(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(require 'misc)
(global-set-key "\M-f" 'forward-to-word)
