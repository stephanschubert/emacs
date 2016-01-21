;; Hide welcome screen/message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; https://www.masteringemacs.org/article/improving-performance-emacs-display-engine
(setq redisplay-dont-pause t)

(setq ns-use-srgb-colorspace nil)

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
(setq-default css-indent-offset 2)
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

;; Revert buffers automatically when switching branches.
(global-auto-revert-mode t)

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

;; Activate region-state mode to show selected number of lines/characters.
(region-state-mode 1)

;; Show inline colors
(rainbow-mode t)
