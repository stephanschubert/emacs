(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(setq scss-compile-at-save nil)
(setq scss-sass-command "bundle exec sass")

;; Details: https://github.com/ShingoFukuyama/helm-css-scss
(require 'helm-css-scss)

;; Allow comment inserting depth at each end of a brace
;;(setq helm-css-scss-insert-close-comment-depth 2)

;; If this value is t, split window appears inside the current window
(setq helm-css-scss-split-with-multiple-windows t)

;; Split direction. 'split-window-vertically or 'split-window-horizontally
(setq helm-css-scss-split-direction 'split-window-vertically)

;; Set local keybind map for css-mode / scss-mode / less-css-mode
;; (dolist ($hook '(css-mode-hook scss-mode-hook less-css-mode-hook))
;;   (add-hook
;;    $hook (lambda ()
;;            (local-set-key (kbd "s-i") 'helm-css-scss)
;;            (local-set-key (kbd "s-I") 'helm-css-scss-back-to-last-point))))

;; (define-key isearch-mode-map (kbd "s-i") 'helm-css-scss-from-isearch)
;; (define-key helm-css-scss-map (kbd "s-i") 'helm-css-scss-multi-from-helm-css-scss)
