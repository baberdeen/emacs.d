This library provides a couple methods for quickly finding any file
in a given project.  It depends on GNU find.

A project is found by searching up the directory tree until a file
is found that matches `ffip-project-file'.  (".git" by default.)
You can set `ffip-project-root-function' to provide an alternate
function to search for the project root.  By default, it looks only
for files whose names match `ffip-patterns',

If you have so many files that it becomes unwieldy, you can set
`ffip-find-options' to a string which will be passed to the `find'
invocation in order to exclude irrelevant subdirectories.  For
instance, in a Ruby on Rails project, you may be interested in all
.rb files that don't exist in the "vendor" directory.  In that case
you could set `ffip-find-options' to "-not -regex \".*vendor.*\"".

All these variables may be overridden on a per-directory basis in
your .dir-locals.el.  See (info "(Emacs) Directory Variables") for
details.

Recommended binding: (global-set-key (kbd "C-x f") 'find-file-in-project)
