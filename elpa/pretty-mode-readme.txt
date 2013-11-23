Minor mode for redisplaying parts of the buffer as pretty symbols
originally modified from Trent Buck's version at http://paste.lisp.org/display/42335,2/raw
Also includes code from `sml-mode'
See also http://www.emacswiki.org/cgi-bin/wiki/PrettyLambda

Released under the GPL. No implied warranties, etc. Use at your own risk.

Arthur Danskin <arthurdanskin@gmail.com>, March 2008
Grant Rettke <grettke@acm.org>, January 2013
Dmitri Akatov <akatov@gmail.com>, April 2013


to install:
(require 'pretty-mode)
and
(global-pretty-mode 1)
or
(add-hook 'my-pretty-language-hook 'turn-on-pretty-mode)
