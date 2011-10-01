; Hide welcome screen/message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

; Use terminus as font
(set-default-font "-*-terminus-medium-r-*-*-*-120-75-75-*-*-iso8859-15")

; UTF-8 please
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

; Lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

; Line-wrapping
(set-default 'fill-column 80)

; No blinking cursor
(blink-cursor-mode -1)

; 1 tab == 2 spaces; EOD
(setq-default c-basic-offset 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

; Ensure scrolling is enabled
(unless (eq system-type 'darwin)
  (mouse-wheel-mode t)
)

; Don't beep just flash
(setq visible-bell t)

; Only 'y' and 'n' please
(fset 'yes-or-no-p 'y-or-n-p)

; Highlight region when selecting
(setq transient-mark-mode t)
(setq cua-highlight-region-shift-only t)

; Syntax highlighting
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

; Highlight matching parentheses when the point is on them
(show-paren-mode 1)

; Save a list of recent files visited
(recentf-mode 1)

; Use firefox
(setq browse-url-browser-function 'browse-url-firefox)

; Setup browse-kill-ring
(vendor 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(setq browse-kill-ring-display-duplicates nil)

; Drag-stuff mode -------------------------------------------------------------
; It's a buffer local mode, so let's activate for each one.

(vendor 'drag-stuff)
(add-hook 'find-file-hook 'drag-stuff-mode)

; Remove unused buffers automatically
(require 'midnight)
