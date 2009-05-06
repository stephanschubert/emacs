(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

; Explicit loading without load-path adjustment because
; some names could clash with other libraries.
(load "jazen/bindings")
(load "jazen/custom")
(load "jazen/global")
(load "jazen/defuns")
(load "jazen/shell")

(vendor 'color-theme)
(load "jazen/theme")

(vendor 'icicles)
(icy-mode)

