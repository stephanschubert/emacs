(vendor 'haml-mode)

(add-hook 'haml-mode-hook
          '(lambda ()
             (define-key haml-mode-map (kbd "<return>") 'haml-reindent-then-newline-and-indent)))

(defun haml-reindent-then-newline-and-indent ()
  (interactive "*")
  (newline)
  (save-excursion
    (end-of-line 0)
    (indent-according-to-mode)
    (delete-region (point) (progn (skip-chars-backward " \t") (point))))
  (indent-according-to-mode))