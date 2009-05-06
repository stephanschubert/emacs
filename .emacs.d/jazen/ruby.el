(eval-after-load 'ruby-mode
	'(progn
		 (add-hook 'ruby-mode-hook 'inf-ruby-keys)
		 (define-key ruby-mode-map (kbd "RET") 'ruby-reindent-then-newline-and-indent)
))

; There are all ruby files
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.sake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))

; We never want to edit Rubinius bytecode
(add-to-list 'completion-ignored-extensions ".rbc")

(defun ruby-reindent-then-newline-and-indent ()
	(interactive "*")
  (newline)
  (save-excursion
    (end-of-line 0)
    (indent-according-to-mode)
    (delete-region (point) (progn (skip-chars-backward " \t") (point))))
  (indent-according-to-mode))