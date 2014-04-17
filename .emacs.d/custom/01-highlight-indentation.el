(require 'highlight-indentation)

(add-hook 'enh-ruby-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(add-hook 'coffee-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(set-face-background 'highlight-indentation-face "#333")
(set-face-background 'highlight-indentation-current-column-face "#333")
