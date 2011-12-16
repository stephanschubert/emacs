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

; Duplicate line at point
(global-set-key (kbd "C-x y") 'jzn/duplicate-line)

; Duplicate line at point and comment original.
(global-set-key (kbd "C-x c") (lambda()(interactive)(jzn/duplicate-line t)))

; M-x query-replace
(global-set-key (kbd "<f6>") 'query-replace)

; M-g g (goto line)
(global-set-key (kbd "<f5>") 'goto-line)

; Delete buffer AND file (you will be prompted)
(global-set-key (kbd "C-c k") 'delete-this-buffer-and-file)

; Move to beginning/end of line or to the previous/next line if already there.
(global-set-key (kbd "C-e") 'jzn/move-end-of-line-or-next-line)
(global-set-key (kbd "C-a") 'jzn/move-start-of-line-or-previous-line)
