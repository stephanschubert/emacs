;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/.emacs.d/bundle/smartparens")
(add-to-list 'load-path "~/.emacs.d/custom")

(load "00-common")
(load "00-bindings")
(load "00-functions")
(load "01-ace-jump-mode")
(load "01-ag")
(load "01-company-mode")
(load "01-coffee-mode")
(load "01-counsel")
(load "01-dash")
(load "01-dockerfile")
(load "01-expand-region")
(load "01-flycheck")
(load "01-haml")
(load "01-helm")
(load "01-highlight-indentation")
(load "01-ibuffer")
(load "01-isearch")
(load "01-jabber")
(load "01-key-chord")
(load "01-magit")
(load "01-powerline")
(load "01-projectile")
(load "01-ruby")
(load "01-smartparens")
(load "01-window-number")
(load "01-wrap-region")

(add-to-list 'load-path "~/.emacs.d/jazen")
(add-to-list 'load-path "~/.emacs.d/vendor")

;; Explicit loading without load-path adjustment because
;; some names could clash with other libraries.

(load "defuns")
(load "bindings")
(load "custom")
(load "osx")
;; (load "global")
(load "shell")
;(load "ruby")
;(load "rails")
(load "yaml")
(load "sass")
(load "01-scss")
;; (load "icicles") Broken?
(load "mustache")
(load "scss")
(load "textile")
(load "yasnippet")
;;(load "nxml")
;;(load "restclient")

;; Got some issues so will be loaded last so it wont interfere with other stuff.
(load "theme")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(mode-line-format
   (quote ("%e"
 (:eval
  (let*
      ((active
        (powerline-selected-window-active))
       (mode-line
        (if active 'mode-line 'mode-line-inactive))
       (face1
        (if active 'powerline-active1 'powerline-inactive1))
       (face2
        (if active 'powerline-active2 'powerline-inactive2))
       (separator-left
        (intern
         (format "powerline-%s-%s"
                 (powerline-current-separator)
                 (car powerline-default-separator-dir))))
       (separator-right
        (intern
         (format "powerline-%s-%s"
                 (powerline-current-separator)
                 (cdr powerline-default-separator-dir))))
       (lhs
        (list
         (powerline-raw "%l:%c " face1 'l)
         (funcall separator-left face1 mode-line)
         (powerline-raw "%*" nil 'l)
         (when powerline-display-buffer-size
           (powerline-buffer-size nil 'l))
         (when powerline-display-mule-info
           (powerline-raw mode-line-mule-info nil 'l))
         (powerline-buffer-id nil 'l)
         (when
             (and
              (boundp 'which-func-mode)
              which-func-mode)
           (powerline-raw which-func-format nil 'l))
         (powerline-raw " ")
         (funcall separator-left mode-line face1)
         (when
             (boundp 'erc-modified-channels-object)
           (powerline-raw erc-modified-channels-object face1 'l))
         (powerline-major-mode face1 'l)
         (powerline-process face1)
         (powerline-minor-modes face1 'l)
         (powerline-narrow face1 'l)
         (powerline-raw " " face1)
         (funcall separator-left face1 face2)
         (powerline-vc face2 'r)
         (when
             (bound-and-true-p nyan-mode)
           (powerline-raw
            (list
             (nyan-create))
            face2 'l))))
       (rhs
        (list
         (powerline-raw global-mode-string face2 'r)
         ;;(funcall separator-right face2 face1)
         ;; (unless window-system
         ;;   (powerline-raw
         ;;    (char-to-string 57505)
         ;;    face1 'l))
         (funcall separator-right face2 face1)
         ;;(powerline-raw " ")
         (powerline-raw " %4p" face1 'r)
         (when powerline-display-hud
           (powerline-hud face2 face1)))))
    (concat
     (powerline-render lhs)
     (powerline-fill face2
                     (powerline-width rhs))
     (powerline-render rhs))))))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :background "color-197" :foreground "black" :weight normal))))
 '(flycheck-color-mode-line-info-face ((t (:inherit flycheck-fringe-info :foreground "green" :weight normal))))
 '(flycheck-color-mode-line-warning-face ((t (:inherit flycheck-fringe-warning :foreground "yellow" :weight normal))))
 '(flycheck-error ((t (:underline "color-197")))))
