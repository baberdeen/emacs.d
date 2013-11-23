;;
;; flyspell, add to mode hooks for each language we
;; are interested in
;;

(require 'flyspell)
(add-hook 'python-mode-hook '(lambda () (flyspell-prog-mode)))
(add-hook 'c-mode-hook '(lambda () (flyspell-prog-mode)))

