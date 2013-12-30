(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/.emacs.d/custom")

(load "00-common")

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/egg")

; Explicit loading without load-path adjustment because
; some names could clash with other libraries.

(load "jazen/defuns")
(load "jazen/bindings")
(load "jazen/custom")
(load "jazen/osx")
;;(load "jazen/global")
(load "jazen/shell")
(load "jazen/ruby")
(load "jazen/rails")
(load "jazen/yaml")
(load "jazen/haml")
(load "jazen/sass")
(load "jazen/theme")
;(load "jazen/icicles") Broken?
(load "jazen/mustache")
(load "jazen/scss")
(load "jazen/textile")
;(load "jazen/jabber") Obsolete?
(load "jazen/yasnippet")
;(load "jazen/cucumber") Obsolete?
(load "jazen/nxml")
;(load "jazen/javascript") Broken?
(load "jazen/restclient")
(load "jazen/window-number")

(vendor 'egg)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

; Always run in server mode
(if (not (server-mode)) (server-start))
