(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/egg")

(vendor 'idle-highlight)
(idle-highlight)

(vendor 'color-theme)
(vendor 'icicles)
(icy-mode)

(vendor 'egg)

; Explicit loading without load-path adjustment because
; some names could clash with other libraries.

(load "jazen/bindings")
(load "jazen/custom")
(load "jazen/global")
(load "jazen/defuns")
(load "jazen/shell")
(load "jazen/ruby")
(load "jazen/rails")
(load "jazen/theme")
(load "jazen/yaml")
