;;
;; highlight parenthesis
;;

(require 'highlight-parentheses)
(add-hook 'python-mode-hook '(lambda () (highlight-parentheses-mode)))

