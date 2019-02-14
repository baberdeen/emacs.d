;;
;; usefull text/programing stuff
;;

(defun goto-match-paren (arg)
     "Go to the matching parenthesis if on parenthesis. Else go to the
     opening parenthesis one level up."
     (interactive "p")
     (cond ((looking-at "\\s\(") (forward-list 1))
           (t
            (backward-char 1)
            (cond ((looking-at "\\s\)")
                   (forward-char 1) (backward-list 1))
                  (t
                   (while (not (looking-at "\\s("))
                     (backward-char 1)
                     (cond ((looking-at "\\s\)")
                            (message "->> )")
                            (forward-char 1)
                            (backward-list 1)
                            (backward-char 1)))
                     ))))))

(global-set-key [(control \]) ] 'goto-match-paren)

;;
;; deleteword also eats trailing interword space
;;

(defun my-whack-word (arg)
     "
     delete a word and its following white space
     "
      (interactive "P")
      ( let () 
          (kill-word 1)
          (whack-whitespace 0)
;;          (just-one-space)
	  
      )
)

(defun whack-whitespace (arg)
      "Delete all white space from point to the next word.  With prefix ARG
    delete across newlines as well.  The only danger in this is that you
    don't have to actually be at the end of a word to make it work.  It
    skips over to the next whitespace and then whacks it all to the next
    word."
      (interactive "P")
      (let ((regexp '"[ \t]+" )) 
        (re-search-forward regexp nil t)
        (replace-match "" nil nil)))


(global-set-key [(meta d)] 'my-whack-word)

;; want to export org files as markdown

(eval-after-load "org"
  '(require 'ox-md nil t))
