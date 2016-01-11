(require 'ivy)

(ivy-mode t)
(setq ivy-use-virtual-buffers t)

(global-set-key (kbd "C-s") #'swiper)

;; Enable fuzzy matching
(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))

;; If you're going fuzzy all the way, you can do without the initial ^,
;; and simply let flx (hopefully) sort the matches in a nice way:
(setq ivy-initial-inputs-alist nil)
