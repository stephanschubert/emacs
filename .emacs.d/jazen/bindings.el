; Use F7 to switch to a shell buffer and C-u F7 to create a new one
(global-set-key [f7] 'jazen-shell)

; More convenient command cycling
(eval-after-load 'shell
  '(progn
     (define-key shell-mode-map [up] 'comint-previous-input)
     (define-key shell-mode-map [down] 'comint-next-input)
     (define-key shell-mode-map "\C-p" 'comint-previous-input)
     (define-key shell-mode-map "\C-n" 'comint-next-input)))

; Invoke M-x without the Alt key - Note that i mapped CapsLock
; as another Control key using ~/.Xresources
(global-set-key "\C-x\C-m" 'execute-extended-command)

; Prefer backward-kill-word over Backspace
(global-set-key "\C-w" 'backward-kill-word) ; was kill-region
(global-set-key "\C-x\C-k" 'kill-region)    
