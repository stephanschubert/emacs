(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(load "custom")
(load "global")
(load "defuns")

(vendor 'color-theme)
(load "theme")

