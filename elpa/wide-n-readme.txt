   This library modifies commands `narrow-to-region',
   `narrow-to-defun', and `narrow-to-page' (`C-x n n', `C-x n d',
   and `C-x n p') so that the current buffer restriction
   (narrowing) is added to a list of restrictions for the current
   buffer, `wide-n-restrictions'.

   You can then use `C-x n x' to cycle among previous buffer
   restrictions.  Repeating `x' repeats the action: `C-x n x x x x'
   etc.  Each time you hit `x' a different narrowing is made
   current.  This gives you an easy way to browse your past
   narrowings.

   Invoking `C-x n x' with a prefix argument changes the behavior
   as follows:

   * A plain prefix arg (`C-u') widens the buffer completely.

   * A zero numeric prefix arg (e.g `C-0') widens completely
     and resets (empties) the list of restrictions.

   * A numeric prefix arg N takes you directly to the abs(N)th
     previous restriction.  That is, it widens abs(N) times.
     Positive and negative args work the same, except that a
     negative arg also pops entries off the ring: it removes the
     ring entries from the most recent back through the (-)Nth one.

   Be default, `C-x n x' is bound to command `wide-n-repeat'.  If
   you use Emacs 21 then you will want to change this key binding
   to command `wide-n', which is a non-repeatable version.
   Repeatability is not available before Emacs 22.

   Emacs markers are used to record restriction limits, so the same
   restriction is available even if you modify its context.  If for
   any reason `wide-n-restrictions' ever has any entries that use
   buffer positions (numbers) instead of markers, invoking `wide-n'
   corrects this by changing the positions to markers.

   This means that you can serialize `wide-n-restrictions',
   converting all markers to positions, save the value
   persistently, and restore it later.  Library `bookmark+.el' does
   this in order to let you bookmark and restore a list of
   restrictions.

   In normal use, only the interactive use of commands
   `narrow-to-region', `narrow-to-defun', and `narrow-to-page' is
   affected by this library.  When these functions are called
   non-interactively there is normally no change to the value of
   variable `wide-n-restrictions'.  However, if for some reason you
   want to add entries to the restrictions ring when narrowing with
   some Emacs-Lisp code (i.e. non-interactively), you can do so by
   binding variable `wide-n-push-anyway-p' around the narrowing
   call.


 Commands defined here:

   `wide-n', `wide-n-repeat',

 Non-interactive functions defined here:

   `wide-n-markerize', `wide-n-push', `wide-n-repeat-command'.

 Internal variables defined here:

   `wide-n-push-anyway-p', `wide-n-restrictions'.

 ***** NOTE: This EMACS PRIMITIVE has been ADVISED HERE:

   `narrow-to-region'.

 ***** NOTE: The following functions defined in `lisp.el' and
             `page.el' have been REDEFINED here:

   `narrow-to-defun', `narrow-to-page'.
