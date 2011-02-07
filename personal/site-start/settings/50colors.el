(color-theme-tty-dark)

(defun my-describe-theme () ; Show the current theme
      (interactive)
      (message "%s" (car theme-current)))
