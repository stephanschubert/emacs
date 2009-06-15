(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/egg")

; Explicit loading without load-path adjustment because
; some names could clash with other libraries.

(load "jazen/defuns")
(load "jazen/bindings")
(load "jazen/custom")
(load "jazen/global")
(load "jazen/shell")
(load "jazen/ruby")
(load "jazen/rails")
(load "jazen/yaml")
(load "jazen/haml")
(load "jazen/sass")
(load "jazen/theme")
(load "jazen/icicles")
(load "jazen/textile")
(load "jazen/jabber")
(load "jazen/yasnippet")
(load "jazen/cucumber")

(vendor 'egg)