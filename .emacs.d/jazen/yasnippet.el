(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)

(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")
(yas/load-directory "~/.emacs.d/jazen/snippets")