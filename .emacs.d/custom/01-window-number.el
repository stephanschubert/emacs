(require 'window-number)
(window-number-mode 1)

;; The first 'empty' string contains a regular space and a 'thin space'
;; and the second 'empty' string contains an 'en space'.
(defun window-number-string ()
  "Returns the string containing the number of the current window"
  (propertize
   (concat "  " (number-to-string (window-number)) " ")
   'face
   'window-number-face))
