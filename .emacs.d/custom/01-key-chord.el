(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "jj" 'ace-jump-word-mode)
(key-chord-define-global "jk" 'ace-jump-char-mode)
(key-chord-define-global "jl" 'ace-jump-line-mode)
(key-chord-define-global "öö" "[]\C-b")
(key-chord-define-global "ää" "{}\C-b")
(key-chord-define-global "uu" 'undo)
(key-chord-define-global "yy" 'helm-show-kill-ring)
(key-chord-define-global "++" 'er/expand-region)
