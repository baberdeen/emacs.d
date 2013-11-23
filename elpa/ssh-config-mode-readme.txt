* Fontifys the ssh config keywords.
* keys for skipping from host section to host section.
* Add the following to your startup file.
  (autoload 'ssh-config-mode "ssh-config-mode" t)
  (add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))
  (add-hook 'ssh-config-mode-hook 'turn-on-font-lock)
