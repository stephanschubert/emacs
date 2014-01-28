(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/.emacs.d/bundle/smartparens")
(add-to-list 'load-path "~/.emacs.d/custom")

(load "00-common")
(load "01-ag")
(load "01-auto-complete")
(load "01-ido")
(load "01-projectile")
(load "01-ruby")
(load "01-smartparens")

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/egg")

;; Explicit loading without load-path adjustment because
;; some names could clash with other libraries.

(load "jazen/defuns")
(load "jazen/bindings")
(load "jazen/coffeescript")
(load "jazen/custom")
(load "jazen/osx")
;; (load "jazen/global")
(load "jazen/shell")
(load "jazen/ruby")
(load "jazen/rails")
(load "jazen/yaml")
(load "jazen/haml")
(load "jazen/sass")
;; (load "jazen/icicles") Broken?
(load "jazen/mustache")
(load "jazen/scss")
(load "jazen/textile")
(load "jazen/yasnippet")
(load "jazen/nxml")
(load "jazen/restclient")
(load "jazen/window-number")

(vendor 'egg)

;; Always run in server mode
(if (not (server-mode)) (server-start))

;; Got some issues so will be loaded last so it wont interfere with other stuff.
(load "jazen/theme")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
