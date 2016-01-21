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
(load "01-ivy")
(load "01-highlight-indentation")
(load "01-ibuffer")
(load "01-jabber")
(load "01-key-chord")
(load "01-key-combo")
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
 '(ag-reuse-window t t)
 '(coffee-args-compile (quote ("-c" "-m" "--no-header" "--bare")))
 '(coffee-tab-width 4)
 '(helm-css-scss-split-with-multiple-windows t)
 '(js-indent-level 2)
 '(mode-line-format
   (quote
    ("%e"
     (:eval
      (let*
          ((active
            (powerline-selected-window-active))
           (mode-line
            (if active
                (quote mode-line)
              (quote mode-line-inactive)))
           (face1
            (if active
                (quote powerline-active1)
              (quote powerline-inactive1)))
           (face2
            (if active
                (quote powerline-active2)
              (quote powerline-inactive2)))
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
             (powerline-raw "%l:%c " face1
                            (quote l))
             (funcall separator-left face1 mode-line)
             (powerline-raw "%*" nil
                            (quote l))
             (when powerline-display-buffer-size
               (powerline-buffer-size nil
                                      (quote l)))
             (when powerline-display-mule-info
               (powerline-raw mode-line-mule-info nil
                              (quote l)))
             (powerline-buffer-id nil
                                  (quote l))
             (when
                 (and
                  (boundp
                   (quote which-func-mode))
                  which-func-mode)
               (powerline-raw which-func-format nil
                              (quote l)))
             (powerline-raw " ")
             (funcall separator-left mode-line face1)
             (when
                 (boundp
                  (quote erc-modified-channels-object))
               (powerline-raw erc-modified-channels-object face1
                              (quote l)))
             (powerline-major-mode face1
                                   (quote l))
             (powerline-process face1)
             (powerline-minor-modes face1
                                    (quote l))
             (powerline-narrow face1
                               (quote l))
             (powerline-raw " " face1)
             (funcall separator-left face1 face2)
             (powerline-vc face2
                           (quote r))
             (when
                 (bound-and-true-p nyan-mode)
               (powerline-raw
                (list
                 (nyan-create))
                face2
                (quote l)))))
           (rhs
            (list
             (powerline-raw global-mode-string face2
                            (quote r))
             (funcall separator-right face2 face1)
             (powerline-raw " %4p" face1
                            (quote r))
             (when powerline-display-hud
               (powerline-hud face2 face1)))))
        (concat
         (powerline-render lhs)
         (powerline-fill face2
                         (powerline-width rhs))
         (powerline-render rhs)))))))
  '(window-number-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-mode-line-fail ((t (:inherit compilation-error :foreground "Red1" :weight bold))))
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :background "color-197" :foreground "black"))))
 '(flycheck-color-mode-line-info-face ((t (:inherit flycheck-fringe-info :foreground "green" :weight normal))))
 '(flycheck-color-mode-line-warning-face ((t (:inherit flycheck-fringe-warning :foreground "yellow" :weight normal))))
 '(flycheck-error ((t (:underline "color-197"))))
 '(mode-line ((t (:background "color-236" :foreground "color-242"))))
 '(mode-line-buffer-id ((t (:foreground "white"))))
 '(mode-line-inactive ((t (:background "color-235" :foreground "cyan" :weight light))))
 '(powerline-active1 ((t (:background "color-235" :foreground "color-238"))))
 '(powerline-active2 ((t (:background "grey40" :foreground "black"))))
 '(powerline-inactive1 ((t (:background "color-235" :foreground "cyan"))))
 '(powerline-inactive2 ((t (:background "grey20" :foreground "color-30"))))
 '(window-number-face ((t (:background "color-52" :foreground "white"))) t))
