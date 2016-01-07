(require 'coffee-mode)
(require 'sourcemap)

(custom-set-variables
 '(coffee-tab-width 4)
 '(coffee-args-compile '("-c" "-m" "--no-header" "--bare")))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map (kbd "M-c") 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "M-C") 'coffee-compile-region)
     (define-key coffee-mode-map (kbd "M-r") 'coffee-repl)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

;; Jump to the corresponding point after compilation and remove the sourcemap file
(defun jzn/coffee-after-compile-hook (props)
  (sourcemap-goto-corresponding-point props)
  (delete-file (plist-get props :sourcemap)))

(add-hook 'coffee-after-compile-hook 'jzn/coffee-after-compile-hook)

;; Automatically clean up bad whitespace and only show bad whitespace
(setq whitespace-action '(auto-cleanup))
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))
