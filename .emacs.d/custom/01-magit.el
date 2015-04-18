(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)

; Use ivy for completion
(setq magit-completing-read-function 'ivy-completing-read)
