;; Hide welcome screen/message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Use terminus as font
(set-default-font "-*-terminus-medium-r-*-*-*-120-75-75-*-*-iso8859-15")

;; To get rid of Weird color escape sequences in Emacs.
;; Instruct Emacs to use emacs term-info not system term info
;; http://stackoverflow.com/questions/8918910/weird-character-zsh-in-emacs-terminal
(setq system-uses-terminfo nil)

;; Prefer UTF-8 encoding
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Line-wrapping
(set-default 'fill-column 80)

;; No blinking cursor
(blink-cursor-mode -1)

;; 1 tab == 2 spaces; EOD
(setq-default c-basic-offset 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; Use windmove bindings
;; Navigate between windows using Alt-1, Alt-2, Shift-left, Shift-up, Shift-right
;; OSX fix: http://zurktech.blogspot.ch/2014/01/emacs-windmove-and-mavericks-terminalapp.html
(define-key input-decode-map "\e[1;2A" [S-up])
(windmove-default-keybindings)

;; Don't beep just flash
(setq visible-bell t)

;; Only 'y' and 'n' please
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight region when selecting
(setq transient-mark-mode t)
(setq cua-highlight-region-shift-only t)

;; Syntax highlighting
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

;; Highlight matching parentheses when the point is on them
(show-paren-mode 1)

;; Save a list of recent files visited
(recentf-mode 1)

;; Stop polluting the directory with auto-saved files and backup
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Number of lines of continuity when scrolling by screenfuls.
(setq next-screen-context-lines 0)

(setq sentence-end-double-space t)
(setq next-line-add-newlines t)
(setq require-final-newline t)

(setq-default line-spacing nil)
(setq fill-column 70)
(setq line-move-visual nil)
(setq show-trailing-whitespace t)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq visible-bell t)

;; (vendor 'browse-kill-ring)
;; (browse-kill-ring-default-keybindings)
;; (setq browse-kill-ring-display-duplicates nil)

;; ;; Drag-stuff mode -------------------------------------------------------------
;; ;; It's a buffer local mode, so let's activate for each one.

;; (vendor 'drag-stuff)
;; (add-hook 'find-file-hook 'drag-stuff-mode)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; (defun smart-open-line-above ()
;;   "Insert an empty line above the current line.
;; Position the cursor at it's beginning, according to the current mode."
;;   (interactive)
;;   (move-beginning-of-line nil)
;;   (newline-and-indent)
;;   (forward-line -1)
;;   (indent-according-to-mode))
;;
;; (global-set-key (kbd "C-o") 'smart-open-line-above)
