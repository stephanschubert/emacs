; Support searching by regexp
(setq search-whitespace-regexp "[ \t\r\n]+")
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
