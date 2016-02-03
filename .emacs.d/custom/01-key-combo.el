(global-key-combo-mode t)

;; JS modes are enabled by default - let's add coffee-mode too..
(add-to-list 'key-combo-common-mode-hooks 'coffee-mode-hook)

(key-combo-load-default)
