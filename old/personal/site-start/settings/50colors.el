(color-theme-standard)

(defun my-describe-theme () ; Show the current theme
      (interactive)
      (message "%s" (car theme-current)))
