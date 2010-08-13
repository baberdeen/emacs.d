(autoload 'dot-mode "dot-mode" nil t) ; vi `.' command emulation
(global-set-key [(control ?.)] (lambda () (interactive) (dot-mode 1)
                                   (message "Dot mode activated.")))

(require 'dot-mode)
(add-hook 'find-file-hooks 'dot-mode-on)
