(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '(("melpa" . "https://melpa.org/packages/")
               ("gnu" . "http://elpa.gnu.org/packages/")
               ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (setq use-package-verbose t)
  (require 'use-package))

(use-package auto-package-update
  :ensure t
  :config
  (auto-package-update-maybe))

(use-package bind-key :ensure t)
(use-package diminish :ensure t)

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :init
  (ivy-mode 1)
  :bind
  ("C-s" . swiper) ;; Was forward i-search
  :config
  (setq ivy-wrap t)                   ;; Wrap while traversing candidates in mini-buf
  (setq ivy-use-virtual-buffers t)    ;; Show recently killed buffers when calling `ivy-switch-buffer'
  (setq ivy-virtual-abbreviate 'full) ;; Show the full virtual file paths
  (setq ivy-count-format "%d/%d ")    ;; Show current/all match count
  (setq ivy-extra-directories nil)    ;; Do not show "./" and "../" in the `counsel-find-file' completion list

  ;; If you're going fuzzy all the way, you can do without the initial ^,
  ;; and simply let flx (hopefully) sort the matches in a nice way:
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (setq ivy-initial-inputs-alist nil))

(use-package quickrun
  :ensure t
  :config
  (setq quickrun-focus-p nil))

(use-package nyan-mode
  :init (nyan-mode 1))

(use-package web-mode
  :ensure t
  :mode (("\.jsx$" . web-mode)
         ("\.html$" . web-mode)
         ("\.html\.erb$" . web-mode)
         ("\.s?css$" . web-mode)
         ("\.mustache$" . web-mode))
  :config
  (setq web-mode-content-types-alist
        '(("jsx" . "\.jsx?$")))
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-enable-auto-pairing t)
)

(use-package clojure-mode
  :init
  (progn
    (add-hook 'clojure-mode-hook #'prettify-symbols-mode))

  :mode (("\.clj$"      . clojure-mode)
         ("\.cljs$"     . clojure-mode)
         ("\.cljx$"     . clojure-mode)
         ("\.edn$"      . clojure-mode)
         ("\.boot$"     . clojure-mode)
         ("\.cljs\.hl$" . clojure-mode))

  :config
  (setq clojure--prettify-symbols-alist
        '(("fn" . ?λ)
          ("not=" . ?≠)
          ("identical?" . ?≡)))
  (setq prettify-symbols-unprettify-at-point 'right-edge))

(use-package lisp-mode
  :init
  (progn
    (add-hook 'lisp-mode-hook #'prettify-symbols-mode)
    (add-hook 'emacs-lisp-mode-hook #'prettify-symbols-mode))
  :config
  (setq lisp--prettify-symbols-alist
        '(("lambda" . ?λ)
          ("compose" . ?∘)
          ("curry" . ?»)
          ("rcurry" . ?«)
          ("eq" . ?=)))
  (setq prettify-symbols-unprettify-at-point 'right-edge))

;; (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
;;     (setq exec-path (append exec-path '("/usr/local/bin")))
;; (add-to-list 'load-path "/usr/local/bin")
;; (autoload 'tern-mode "tern" nil t)

(use-package js2-mode
  :mode (("\.js$" . js2-mode)
         ("\.jsx$" . js2-jsx-mode))
  :init
  (setq js2-highlight-level 3
        js2-strict-trailing-comma-warning nil
        js2-strict-missing-semi-warning nil
        js2-missing-semi-one-line-override t
        js2-allow-rhino-new-expr-initializer nil
        js2-include-node-externs t
        js2-warn-about-unused-function-arguments t
        js2-basic-offset 2)
  (add-hook 'js2-mode-hook (lambda ()
                             (subword-mode 1)
                             (diminish 'subword-mode)))
  (add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
  ;; (rename-modeline "js2-mode" js2-mode "JS2")
  :config
  (use-package tern
    :diminish tern-mode
    :init
    (add-hook 'js2-mode-hook 'tern-mode))
  (use-package js-doc)
  (use-package js2-refactor
    :diminish js2-refactor-mode
    :init
    (add-hook 'js2-mode-hook #'js2-refactor-mode)
    :config
    (js2r-add-keybindings-with-prefix "C-c r")))

;; (use-package js2-mode
;;   :mode (("\\.js\\'" . js2-mode)
;;          ("\\.jsx\\'" . js2-jsx-mode))
;;   ;; :diminish js2-minor-mode
;;   :commands (js2-mode js-mode js2-minor-mode)
;;   :init (progn
;;           (use-package tern
;;             ;; :diminish " T"
;;             :commands (tern-mode)
;;             :init (progn
;;                     (add-hook 'js-mode-hook 'tern-mode)))
;;           (add-hook 'js-mode-hook 'js2-minor-mode)
;;           (add-to-list 'interpreter-mode-alist '("node" . js-mode))))
;; (rename-modeline "js2-mode" js2-mode "JS2")

;; (use-package tern
;;   :commands (tern-mode)
;;   :init
;;   (progn
;;     (add-hook 'js-mode-hook 'tern-mode))
;;   )

;;   :config
;;   (progn
;;     (define-clojure-indent
;;       (defroutes 'defun)
;;       (GET 2)
;;       (POST 2)
;;       (PUT 2)
;;       (DELETE 2)
;;       (HEAD 2)
;;       (ANY 2)
;;       (context 2)
;;       (let-routes 1))

;;     (define-clojure-indent
;;       (form-to 1))

;;     (define-clojure-indent
;;       (match 1)
;;       (are 2)
;;       (checking 2)
;;       (async 1))

;;     (define-clojure-indent
;;       (select 1)
;;       (insert 1)
;;       (update 1)
;;       (delete 1))

;;     (define-clojure-indent
;;       (run* 1)
;;       (fresh 1))

;;     (define-clojure-indent
;;       (extend-freeze 2)
;;       (extend-thaw 1))

;;     (define-clojure-indent
;;       (go-loop 1))

;;     (define-clojure-indent
;;       (this-as 1)
;;       (specify 1)
;;       (specify! 1))


;;     (defun toggle-nrepl-buffer ()
;;       "Toggle the nREPL REPL on and off"
;;       (interactive)
;;       (if (string-match "cider-repl" (buffer-name (current-buffer)))
;;           (delete-window)
;;         (cider-switch-to-repl-buffer)))

;;     (defun cider-save-and-refresh ()
;;       (interactive)
;;       (save-buffer)
;;       (call-interactively 'cider-refresh))

;;     ;; (evil-leader/set-key "eb" 'cider-eval-buffer)
;;     ;; (evil-leader/set-key "ee" 'cider-eval-last-sexp)
;;     ;; (evil-leader/set-key "er" 'cider-eval-region)
;;     ;; (evil-leader/set-key "ef" 'cider-eval-defun-at-point)

;;     ;; (evil-leader/set-key "cd" 'cider-doc)
;;     ;; (evil-leader/set-key "cc" 'cider-connect)
;;     ;; (evil-leader/set-key "ct" 'cider-test-run-tests)
;;     ;; (evil-leader/set-key "cr" 'toggle-nrepl-buffer)
;;     ;; (evil-leader/set-key "cf" 'cider-save-and-refresh)

;;     (global-set-key (kbd "s-r") 'cider-save-and-refresh)))

;; (require 'diminish)
;; (require 'bind-key)

;; (use-package smooth-scroll
;;   :config
;;   (smooth-scroll-mode 1)
;;   (setq smooth-scroll/vscroll-step-size 1))

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
(load "01-guide-key")
(load "01-haml")
(load "01-helm")
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
;; ;; (load "global")
(load "shell")
;; (load "ruby")
;; (load "rails")
;; (load "yaml")
;; (load "sass")
;;(load "01-scss")
;; ;; (load "icicles") Broken?
;; (load "mustache")
;; (load "scss")
;; (load "textile")
;; (load "yasnippet")
;; ;;(load "nxml")
;; ;;(load "restclient")

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
 '(package-selected-packages
   (quote
    (auto-package-update web-mode quickrun js2-refactor js-doc tern clojure-mode auto-compile use-package)))
 '(tab-always-indent (quote complete))
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
