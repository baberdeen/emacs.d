(global-set-key [(control x) (control b)] 'bs-show) ;; better buffer selector
(global-set-key [(control c) (control f)] 'gtags-find-tag-from-here) ;; better buffer selector
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

;;(setq 
;;  time-stamp-active t          ; do enable time-stamps
;;  time-stamp-line-limit 10     ; check first 10 buffer lines for Time-stamp: <>
;;  time-stamp-format "Last changed %02d-%B-%04y %02H:%02M:%02S by %L, %u") ; date format
;;(add-hook 'write-file-hooks 'time-stamp) ; update when saving


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

(global-set-key [(control x) (T)] 'toggle-window-split)

;;
;; other stuff
;;

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; default to unified diffs
(setq diff-switches "-u")

;;(global-set-key "\C-x\C-b" 'buffer-menu)
 (global-set-key "\C-x\C-b" 'electric-buffer-list)
(require 'misc)
(global-set-key "\M-f" 'forward-to-word)

;;
;; some usefull defs
;;


(setq-default show-trailing-whitespace t)      ;; show trailing whitespace on lines
(setq-default default-indicate-empty-lines t)  ;; show blank lines at end of buffer (doesnt work ?)
(setq split-width-threshold nil)               ;; never split vertically
(modify-syntax-entry ?_ "w")

;;
;; want dired-x
;;

(add-hook 'dired-load-hook
               (lambda ()
                 (load "dired-x")
                 ;; Set dired-x global variables here.  For example:
                 ;; (setq dired-guess-shell-gnutar "gtar")
                 ;; (setq dired-x-hands-off-my-keys nil)
                 ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    (dired-omit-mode 1)
	    ))


(require 'buff-menu+)
(add-to-list 'same-window-buffer-names "*Buffer List*")

;; This takes way to long when using emacs in the RC tree
;;(require 'git)

;; auttosave sucks over nfs

(setq auto-save-default nil)

;; Kills all them buffers except scratch
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
	    (buffer-list))
  (delete-other-windows))

;; Kills live buffers, leaves some emacs work buffers
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-some-buffers (&optional list)
  "For each buffer in LIST, kill it silently if unmodified. Otherwise ask.
LIST defaults to all existing live buffers."
  (interactive)
  (if (null list)
      (setq list (buffer-list)))
  (while list
    (let* ((buffer (car list))
	      (name (buffer-name buffer)))
      (and (not (string-equal name ""))
	      (not (string-equal name "*Messages*"))
	        ;; (not (string-equal name "*Buffer List*"))
	         (not (string-equal name "*buffer-selection*"))
		    (not (string-equal name "*Shell Command Output*"))
		       (not (string-equal name "*scratch*"))
		          (/= (aref name 0) ? )
			     (if (buffer-modified-p buffer)
				        (if (yes-or-no-p
					         (format "Buffer %s has been edited. Kill? " name))
					       (kill-buffer buffer))
			            (kill-buffer buffer))))
    (setq list (cdr list))))


;; get rid of the toolbar on top of the window
(tool-bar-mode 0)
;; Show column number at bottom of screen
(column-number-mode 1)


;;will make the last line end in a carriage return.
(setq require-final-newline t) 

(require 'redo+)
  (global-set-key (kbd "C-?") 'redo)

;; Centering code stolen from somewhere and restolen from 
;; http://www.chrislott.org/geek/emacs/dotemacs.html
;; centers the screen around a line...
(global-set-key [(control l)]  'centerer)

(defun centerer ()
   "Repositions current line: once middle, twice top, thrice bottom"
   (interactive)
   (cond ((eq last-command 'centerer2)  ; 3 times pressed = bottom
	    (recenter -1))
	  ((eq last-command 'centerer1)  ; 2 times pressed = top
	     (recenter 0)
	       (setq this-command 'centerer2))
	   (t                             ; 1 time pressed = middle
	      (recenter)
	        (setq this-command 'centerer1))))

;; show ascii table
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %c\n" i i))))
  (beginning-of-buffer))

(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)

;--- Function for Control shift tab -----
(defun c-shift-tab-buffer ()
  ;switches to two buffers ago
  (interactive)
  (switch-to-buffer (other-buffer (other-buffer (current-buffer) t)))
) 

;(global-set-key [(control kp-tab)] 'c-shift-tab-buffer)

;;; replace

(defun substitute-regexp (substitution)
  "Use s/old/new/g regexp syntax for `query-replace'."
  (interactive
   (list
    (read-from-minibuffer "Substitute regexp: " '("s///g" . 3) nil nil
                          'query-replace-history nil t)))
  (if (string-match "^s/\\(.*\\)/\\(.*\\)/\\([gi]*\\)" substitution)
      (let* ((sregex (match-string 1 substitution))
             (ssubst (match-string 2 substitution))
             (sflags (match-string 3 substitution))
             (case-fold-search (string-match "i" sflags)))
        (perform-replace
         sregex ssubst (string-match "g" sflags)
         t nil nil nil
         (if (and transient-mark-mode mark-active) (region-beginning))
         (if (and transient-mark-mode mark-active) (region-end))))
    (error "Invalid syntax")))

(setq set-mark-command-repeat-pop 1)
(defun roundring () 
   (interactive)
  "move tghru the mark riung"
  (set-mark-command 1) 
)
;;(global-set-key [(control x) (control x)] 'roundring)

(defun RC () 
   (interactive)
  "Compile the radio controller"
  (compile "make -k PLATFORM=Linux_OE_RC" ) 
)

;;  want gtags mode

(setq c-mode-hook
          '(lambda ()
              (gtags-mode 1)
      ))
(setq vc-handled-backends nil)
