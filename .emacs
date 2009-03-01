;; I want Common Lisp stuff
(require 'cl)

;; Change this if you're using another directory
(defvar emacs-root "~/emacs")

;; Add all elisp directories under emacs-root to the load path
(labels ((add-path (p)
	 (add-to-list 'load-path
		      (concat emacs-root p))))

;; Add custom paths here - Example:
;; (add-path "emacs/lisp")
)

(load-library "my-functions")