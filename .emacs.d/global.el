; Hide welcome screen/message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

; UTF-8 please
(prefer-coding-system 'utf-8)

; Lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; 1 tab == 2 spaces; EOD
(setq-default c-basic-offset 2)
(setq-default tab-width 2)
(setq-default indent-tab-mode nil)

; Highlight region when selecting
(setq cua-highlight-region-shift-only t)


