CAUTION
=======
THIS LIBRARY IS VERY EXPERIMENTAL!!!


Overview
========
This library is an extension of `shell-command'.

What this library does are:

  1. Search for a regexp(*1) from text in current buffer by
     external command(*2).

        (*1) You can write regexp with syntax of external
             command.

        (*2) External commands written in Perl (v5.8 or later
             is required), Ruby (v1.9 or later is required), and
             JavaScript(node.js) are pre-defined in this file.
             To use regexp syntax of your choice, you can
             write your own external command.

  2. Let us browse search results from an external command via
     Emacs user interface like `occur' and `isearch'.

     Also let us apply results of the replacement operation by an
     external command via `query-replace' interface.


REQUIREMENTS
============
By shell scripts defined in this file as default external commands,
perl (>= 5.8), ruby (>= 1.9) or node.js is required.

Also features `cl', `menu-bar' and `re-builder' are required.

For better multilingual support, Emacs (>= 21) may be required.


INSTALLING
==========
To install this library, save this file to a directory in your
`load-path' (you can view the current `load-path' using "C-h v
load-path <RET>" within Emacs), then add the following lines to
your .emacs start up file:

   (require 'foreign-regexp)

   (custom-set-variables
    '(foreign-regexp/regexp-type 'perl) ;; Choose by your preference.
    '(reb-re-syntax 'foreign-regexp)) ;; Tell re-builder to use foreign regexp.


TERMINOLOGY
===========
Technical terms appear in this document are as follows.

FOREIGN REGEXP:
    A regular expression in syntax which is foreign to Emacs.
    Typically, it is not so much backslashy.
    By default, Regular expressions in syntax of `Perl', `Ruby' and
    `JavaScript' can be used as FOREIGN REGEXP with this library.

EXTERNAL COMMAND:
    An external program that gives Emacs the ability to handle
    FOREIGN REGEXP.
    Commands written in `Perl', `Ruby' and `JavaScript' are pre-defined in
    this library.


USAGE EXAMPLE
=============

[Example-1] Query Replace in manner of Perl.

  STEP-1: Set regexp-type to Perl.

       `M-x foreign-regexp/regexp-type/set <RET> perl <RET>'

       NOTE: Once you choose REGEXP-TYPE, Emacs will remember it
             until exit. You can also set and save REGEXP-TYPE for
             next Emacs session by setting value via customize.
             See "COMMANDS(1)" section in this document.

  STEP-2: Run query replace

       `M-s M-% (\d+)---(\d+) <RET> ${1}456${2} <RET>'

       This command replaces text in buffer:

          123---789

       with text:

          123456789

       Variables in replacement string are interpolated by Perl.


[Example-2] Query Replace in manner of Ruby.

  STEP-1: Set regexp-type to Ruby.

       `M-x foreign-regexp/regexp-type/set <RET> ruby <RET>'

  STEP-2: Run query replace

       `M-s M-% (\d+)---(\d+) <RET> #{$1}456#{$2} <RET>'

       This command replaces text in buffer:

          123---789

       with text:

          123456789

       Variables in replacement string are interpolated by ruby
       as if it ware in the string inside of a block of "gsub"
       method.


[Example-3] Query Replace in manner of JavaScript.

  STEP-1: Set regexp-type to JavaScript.

       `M-x foreign-regexp/regexp-type/set <RET> javascript <RET>'

  STEP-2: Run query replace

       `M-s M-% (\d+)---(\d+) <RET> $1456$2 <RET>'

       This command replaces text in buffer:

          123---789

       with text:

          123456789

       Variables in replacement string are interpolated
       as if they are in String.replace method.


COMMANDS(1): SETTING REGEXP-TYPE
================================

 `M-x foreign-regexp/regexp-type/set <RET> REGEXP-TYPE <RET>'

     Set type of regexp syntax to REGEXP-TYPE.
     By default, three regexp-types `perl', `ruby' and
     `javascript' are provided.

     You can also set REGEXP-TYPE via customization interface:

     `M-x customize-apropos <RET> foreign-regexp/regexp-type <RET>'.


COMMANDS(2): SEARCH AND REPLACEMENT
===================================

NOTE: While editing a regular expression on the minibuffer prompt
      of `foreign-regexp' commands below, you can switch to another
      `foreign-regexp' command without losing current editing state.

`M-s M-o REGEXP <RET>'
`M-x foreign-regexp/occur <RET> REGEXP <RET>'

     Show all lines in the current buffer containing a match
     for foreign regexp REGEXP.

`M-s M-% REGEXP <RET> REPLACEMENT <RET>'
`M-x foreign-regexp/query-replace <RET> REGEXP <RET> REPLACEMENT <RET>'

     Replace some matches for foreign regexp REGEXP with REPLACEMENT.
     Note that notation of REPLACEMENT is different for
     each REGEXP-TYPE.

`M-s M-s'
`M-x foreign-regexp/isearch-forward <RET>'

     Begin incremental search for a foreign regexp.

`M-s M-r'
`M-x foreign-regexp/isearch-backward <RET> REGEXP;

     Begin reverse incremental search for a foreign regexp.

`M-s M-f REGEXP <RET>'
`M-x foreign-regexp/non-incremental/search-forward <RET> REGEXP <RET>'

     Search for an foreign regexp REGEXP.

`M-s M-F REGEXP <RET>'
`M-x foreign-regexp/non-incremental/search-backward <RET> REGEXP <RET>'

     Search for an foreign regexp REGEXP backward.

`M-s M-g'
`M-x nonincremental-repeat-search-forward'

     Search forward for the previous search string or regexp.

`M-s M-G'
`M-x nonincremental-repeat-search-backward'

     Search backward for the previous search string or regexp.


COMMANDS(3): WORKING WITH SEARCH OPTIONS
========================================
NOTE: The status of each search option will be displayed by an
      indicator which is put on the minibuffer prompt of each
      `foreign-regexp' command, or put on the mode-line of a
      buffer `*RE-Builder*'. The indicator will be displayed
      like these: `[isxe]' for Perl, `[imxe]' for Ruby and
      `[ie]' for JavaScript.

`M-s M-i'
`M-x foreign-regexp/toggle-case-fold <RET>'

     Toggle search option `case-fold-search'.

`M-s M-m'
`M-x foreign-regexp/toggle-dot-match <RET>'

     Toggle search option `foreign-regexp/dot-match-a-newline-p'.

`M-s M-x'
`M-x foreign-regexp/toggle-ext-regexp <RET>'

     Toggle search option `foreign-regexp/use-extended-regexp-p'.

`M-s M-e'
`M-x foreign-regexp/toggle-eval-replacement <RET>'

     Toggle search option `foreign-regexp/toggle-eval-replacement'.

     When this search option is on, the replacement string for
     a command `foreign-regexp/query-replace' will be evaluated
     as expression. For example, these commands:

       For `Perl':
         `M-s M-% ^ <RET> no strict 'vars';sprintf('%05d: ', ++$LINE) <RET>'

       For `Ruby':
         `M-s M-% ^ <RET> $LINE||=0;sprintf('%05d: ', $LINE+=1) <RET>'

       For `JavaScript':
         `M-s M-% ^ <RET> function (m) {if(typeof(i)=='undefined'){i=0};return ('0000'+(++i)).substr(-5)+': '} <RET>'
         (Replacement will be evaluated as a function in
          `String.replace' method.)

     put line number to beginning of each lines.


COMMANDS(4): CONSTRUCTING REGEXP
================================

`M-x reb-change-syntax <RET> foreign-regexp <RET>'

     Set the syntax used by the `re-builder' to foreign regexp.

`M-s M-l'
`M-x re-builder <RET>'

     Start an interactive construction of a regexp with
     `re-builder'.
     (See also documents of `re-builder')

     NOTE-1: To apply the regexp, which was constructed with
             `re-builder', to the `foreign-regexp' commands,
             call commands below in `*RE-Builder*' buffer:

            `M-s M-o'
            `M-x foreign-regexp/re-builder/occur-on-target-buffer'

                 Run `foreign-regexp/occur' in `reb-target-buffer'
                 with a foreign regexp in the buffer `*RE-Builder*'.

            `M-s M-%'
            `M-x foreign-regexp/re-builder/query-replace-on-target-buffer'

                 Run `foreign-regexp/query-replace' in `reb-target-buffer'
                 with a foreign regexp in the buffer `*RE-Builder*'.

            `M-s M-s'
            `M-x foreign-regexp/re-builder/isearch-forward-on-target-buffer'

                 Run `foreign-regexp/isearch-forward' in `reb-target-buffer'
                 with a foreign regexp in the buffer `*RE-Builder*'.

            `M-s M-r'
            `M-x foreign-regexp/re-builder/isearch-backward-on-target-buffer'

                 Run `foreign-regexp/isearch-backward' in `reb-target-buffer'
                 with a foreign regexp in the buffer `*RE-Builder*'.

            `M-s M-f'
            `M-x foreign-regexp/re-builder/non-incremental-search-forward-on-target-buffer'

                 Run `foreign-regexp/non-incremental/search-forward' in `reb-target-buffer'
                 with a foreign regexp in the buffer `*RE-Builder*'.

            `M-s M-F'
            `M-x foreign-regexp/re-builder/non-incremental-search-backward-on-target-buffer'

                 Run `foreign-regexp/non-incremental/search-backward' in `reb-target-buffer'
                 with a foreign regexp in the buffer `*RE-Builder*'.


     NOTE-2: You can switch search options of the
             `reb-target-buffer' with commands below:

             `M-s M-i'
             `M-x foreign-regexp/re-builder/toggle-case-fold-on-target-buffer'

                 Toggle search option `case-fold-search' of `reb-target-buffer'.

             `M-s M-m'
             `M-x foreign-regexp/re-builder/toggle-dot-match-on-target-buffer'

                 Toggle search option `foreign-regexp/dot-match-a-newline-p'
                 of `reb-target-buffer'.

             `M-s M-x'
             `M-x foreign-regexp/re-builder/toggle-ext-regexp-on-target-buffer'

                 Toggle search option `foreign-regexp/dot-match-a-newline-p'
                 of `foreign-regexp/use-extended-regexp-p'.

`M-\'
`M-x foreign-regexp/quote-meta-in-region <RET>'

     Escape characters in region, that would have special meaning
     in foreign regexp.


COMMANDS(5): ALIGNMENT USING FOREIGN REGEXP
===========================================

`C-M-|'
`M-x align'

     Align region according to pre-defined rules.

     Foreign regexp can be used in a rule by putting an
     `regexp-type' attribute on the rule.

     Example)

       (add-to-list
        'align-rules-list
        '(perl-and-ruby-hash-form

          ;; This rule will be applied when `regexp-type'
          ;; is `perl' or `ruby'.
          (regexp-type . '(perl ruby))

          (regexp . "([ \\t]*)=>[ \\t]*[^# \\t\\n]") ;; Foreign Regexp
          (group  . 1)
          (repeat . t)
          (modes  . '(perl-mode cperl-mode ruby-mode))))

     See also `align-rules-list' and help document of an advice
     of `align-region' for more information about alignment rules.


`M-s M-a REGEXP <RET>'
`M-x foreign-regexp/align <RET> REGEXP <RET>'

     Align the current region using a partial foreign regexp
     read from the minibuffer.

     The foreign regexp read from the minibuffer will be
     supposed to be placed after whitespaces.

     See also `align-regexp'.

`C-u M-s M-a REGEXP <RET> GROUP <RET> SPACING <RET> REPEAT <RET>'
`C-u M-x foreign-regexp/align <RET> REGEXP <RET> GROUP <RET> SPACING <RET> REPEAT <RET>'

     Align the current region using a full foreign regexp
     read from the minibuffer.

     Example)

       < Use regexp of Perl in this example. >

       When texts in region is:

            (one 1)
            (ten 10)
            (hundred 100)
            (thousand 1000)

       Run command on the region with options:

            REGEXP: ([ \t]+)\d
                         |
                         +--- GROUP: 1
                              Alignment will be applied to each
                              lines by inserting whitespaces to
                              the place where the sub-expression
                              specified by GROUP is matched to.
            SPACING: 1
            REPEAT:  y

       Result is:

            (one      1)
            (ten      10)
            (hundred  100)
            (thousand 1000)
                     |
                     +---- Aligned using SPACING spaces.

     See also `align-regexp'.


FOR HACKERS
===========
You can use regexp syntax of your choice of language, if you
write four external commands below with the language:

  `foreign-regexp/replace/external-command'
  `foreign-regexp/quote-meta/external-command'

and install these commands with the function
`foreign-regexp/regexp-type/define'.

See help documents of these variables and function
for more information.


KNOWN PROBLEMS
==============
- Codes aside, this document should be rewritten.
  My English sucks :-(
- On M$-Windows system, virus scanners makes
  foreign regexp commands extremely slow.


WISH LIST
=========
- Better documents.
- Better error messages.
- History for `re-builder'.
- `grep' with foreign regexp?
- `tags-search', `tags-query-replace', `dried-do-search' and
  `dired-do-query-replace-regexp' with foreign regexp?
- `multi-isearch-buffers-regexp', `multi-occur',
  `multi-occur-in-matching-buffers', `how-many', `flush-lines',
  and `keep-lines' with foreign regexp?
- Write Tests.
