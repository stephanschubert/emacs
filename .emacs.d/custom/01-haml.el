(require 'haml-mode)

(defun haml-reindent-then-newline-and-indent ()
  (interactive "*")
  (newline)
  (save-excursion
    (end-of-line 0)
    (indent-according-to-mode)
    (delete-region (point) (progn (skip-chars-backward " \t") (point))))
  (indent-according-to-mode))

(add-hook 'haml-mode-hook
          '(lambda ()
             (define-key haml-mode-map (kbd "RET") 'haml-reindent-then-newline-and-indent)))
