; Unique buffer naming -
; If two or more files have the same name but are in different
; directories, this will present them as "foo/dir-a" and
; "foo/dir-b" which is more convenient than "foo" and "foo<2>".

(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator "/")
