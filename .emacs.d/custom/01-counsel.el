(require 'counsel)

;; Map Alt-x to C-x-m
(global-set-key (kbd "C-x C-m") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)

(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
