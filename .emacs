(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/egg")

; Explicit loading without load-path adjustment because
; some names could clash with other libraries.

(load "jazen/defuns")
(load "jazen/bindings")
(load "jazen/coffeescript")
(load "jazen/custom")
(load "jazen/osx")
(load "jazen/global")
(load "jazen/shell")
(load "jazen/ruby")
(load "jazen/rails")
(load "jazen/yaml")
(load "jazen/haml")
(load "jazen/sass")
(load "jazen/mustache")
(load "jazen/scss")
;(load "jazen/icicles") Broken?
(load "jazen/textile")
(load "jazen/jabber")
(load "jazen/yasnippet")
(load "jazen/cucumber")
(load "jazen/nxml")
(load "jazen/javascript")
(load "jazen/restclient")
(load "jazen/window-number")

(vendor 'egg)

; Always run in server mode
(if (not (server-mode)) (server-start))

; Got some issues so will be loaded last so it wont interfere with other stuff.
(load "jazen/theme")
