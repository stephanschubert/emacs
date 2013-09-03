(vendor 'scss-mode)
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

; Disable compilation on save
(set 'scss-compile-at-save nil)
