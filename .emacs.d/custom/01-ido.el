(require 'flx-ido)
(require 'ido-vertical-mode)

(ido-mode 1)
(ido-vertical-mode 1)
(ido-everywhere 1)

(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
