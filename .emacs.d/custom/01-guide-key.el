(require 'guide-key)

(setq guide-key/guide-key-sequence t)
(setq guide-key/popup-window-position 'bottom)
(setq guide-key/idle-delay 0.5)

(setq guide-key/highlight-command-regexp
      '("jzn/"))

(guide-key-mode 1)
