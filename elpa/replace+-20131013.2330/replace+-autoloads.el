;;; replace+-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (occur-mode-display-occurrence occur-mode-goto-occurrence-other-window
;;;;;;  query-replace-w-options toggle-search/replace-region-as-default
;;;;;;  toggle-replace-w-completion) "replace+" "replace+.el" (21126
;;;;;;  37808))
;;; Generated autoloads from replace+.el

(autoload 'toggle-replace-w-completion "replace+" "\
Toggle whether to use minibuffer completion for `query-replace'.
This toggles the value of option `replace-w-completion-flag'.
During completion, you can insert a SPC or TAB char by preceding it
with `\\[quoted-insert]'.

A non-negative prefix arg means set `replace-w-completion-flag' to t.
A negative prefix arg means set it to nil.

\(fn FORCE-P)" t nil)

(autoload 'toggle-search/replace-region-as-default "replace+" "\
Toggle whether to use the active region text as default.
This toggles the value of option
`search/replace-region-as-default-flag', which affects search and
replace commands.

\(fn MSGP)" t nil)

(autoload 'query-replace-w-options "replace+" "\
Replace some occurrences of OLD text with NEW one.
Fourth and fifth arg START and END specify the region to operate on.

This is the same as command `query-replace', except for the treatment
of a prefix argument.

No PREFIX argument (nil) means replace literal string matches.
Non-negative PREFIX argument means replace word matches.
Negative PREFIX argument means replace regexp matches.

See options `search/replace-region-as-default-flag',
`search/replace-2nd-sel-as-default-flag', and
`search/replace-default-fn' regarding the default values of OLD and
NEW.

Option `replace-w-completion-flag', if non-nil, provides for
minibuffer completion while you type OLD and NEW.  In that case, to
insert a SPC or TAB character, you will need to precede it by `\\[quoted-insert]'.

If option `isearchp-set-region-flag' is non-nil, then select the last
replacement.

\(fn OLD NEW &optional PREFIX START END)" t nil)

(defalias 'list-matching-lines 'occur)

(autoload 'occur-mode-goto-occurrence-other-window "replace+" "\
Go to the occurrence for the current line, in another window.
Highlight the visited line number in the occur buffer.
Highlight the occur regexp in the source buffer.

\(fn)" t nil)

(autoload 'occur-mode-display-occurrence "replace+" "\
Display in another window the occurrence for the current line.
Highlight the visited line number in the occur buffer.
Highlight the occur regexp in the source buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("replace+-pkg.el") (21126 37808 499340))

;;;***

(provide 'replace+-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; replace+-autoloads.el ends here
