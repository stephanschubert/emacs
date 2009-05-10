(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(add-hook 'yaml-mode-hook
					'(lambda ()
						 (define-key yaml-mode-map (kbd "RET") 'newline-and-indent)
))