(add-to-list 'load-path "~/.emacs.d/vendor/restclient")
(vendor 'restclient)
(add-to-list 'auto-mode-alist '("\\.http$" . restclient-mode))
