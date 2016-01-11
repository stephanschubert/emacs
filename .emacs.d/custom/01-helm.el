(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h a") 'helm-apropos)

(setq helm-sources '(
    helm-c-source-buffers
    helm-c-source-recentf
    helm-c-source-file-name-history
    helm-c-source-file-cache
    helm-c-source-files-in-current-dir+
    helm-c-source-locate))

(setq helm-apropos-fuzzy-match t)

(setq helm-ff-skip-boring-files t)
(setq helm-boring-file-regexp-list
  '("\\.#" "\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$"
    "\\.so$" "\\.a$" "\\.elc$" "\\.fas$" "\\.fasl$" "\\.pyc$" "\\.pyo$"))
(setq helm-boring-buffer-regexp-list
  '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc"))
