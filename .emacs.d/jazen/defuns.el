; Reload Emacs configuration on the fly ----------------------------------------

(defun reload-emacs ()
	(interactive)
	(if (bufferp (get-file-buffer "init.el"))
			(save-buffer (get-buffer "init.el")))
	(load-file "~/.emacs.d/init.el")
	(message "Reloaded Emacs configuration successfully."))

; For loading libraries from the vendor directory ------------------------------

(defun vendor (library)
	(let* ((file (symbol-name library))
				 (normal (concat "~/.emacs.d/vendor/" file))
				 (suffix (concat normal ".el")))
		(cond
		 ((file-directory-p normal) (add-to-list 'load-path normal) (require library))
		 ((file-directory-p suffix) (add-to-list 'load-path suffix) (require library))
		 ((file-exists-p suffix) (require library)))))

; Alternate shell command ------------------------------------------------------

(defun jazen-shell (&optional create)
	"Start or switch to an inferior shell process, in a smart way. If a buffer
   with a running shell process exists, simply switch to that buffer.
   If a shell buffer exists, but the shell process is not running, restart the
   shell.If already in an active shell buffer, switch to the next one, if any.
   With prefix argument CREATE always start a new shell."
	(interactive "P")
	(let* ((next-shell-buffer
					(catch 'found
						(dolist (buffer (reverse (buffer-list)))
							(when (string-match "^\\*shell\\*" (buffer-name buffer))
								(throw 'found buffer)))))
				 (buffer (if create
										 (generate-new-buffer-name "*shell*")
									 next-shell-buffer)))
		(shell buffer)))

; ------------------------------------------------------------------------------

(defun jzn/close-other-window ()
	(interactive)
	(other-window 1)
	(delete-window))
(global-set-key (kbd "C-c k") 'jzn/close-other-window)

;; Clear up files before saving them -------------------------------------------

(defun jzn/delete-trailing-blank-lines ()
  "Deletes all blank lines at the end of the file and leaves single
   newline character."
  (interactive)
  (save-excursion
    (goto-char (point-max))
    (newline)              ;; ensures that there is at least one
    (delete-blank-lines))) ;; leaves at most one

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'jzn/delete-trailing-blank-lines)

; ------------------------------------------------------------------------------

(defun jzn/rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

; ------------------------------------------------------------------------------

(defun move-buffer-file (dir)
	"Moves both current buffer and file it's visiting to DIR."
	(interactive "DNew directory: ")
	(let* ((name (buffer-name))
				 (filename (buffer-file-name))
				 (dir
					(if (string-match dir "\\(?:/\\|\\\\)$")
							(substring dir 0 -1) dir))
				 (newname (concat dir "/" name)))
		(if (not filename)
				(message "Buffer '%s' is not visiting a file!" name)
			(progn  (copy-file filename newname 1)
							(delete-file filename)
							(set-visited-file-name newname)
							(set-buffer-modified-p nil)
							t))))

; ------------------------------------------------------------------------------

;; I-search with initial contents
(defvar isearch-initial-string nil)

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))

(global-set-key (kbd "M-s") 'isearch-forward-at-point)


;; ------------------------------------------------------------------------------
;; It is assumed that Transient Mark Mode is enabled globally
;; (transient-mark-mode t)
;; -----------------------------------------------------------------------------

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; -----------------------------------------------------------------------------

(defun delete-this-file ()
  (interactive)
  (or (buffer-file-name) (error "No file is currently being edited."))
  (when (yes-or-no-p "Really delete this file?")
    (delete-file (buffer-file-name))
    (kill-this-buffer)))

(defun prelude-get-positions-of-line-or-region ()
  "Return positions (beg . end) of the current line
or region."
  (let (beg end)
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (cons beg end)))

(defun prelude-duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated.  However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (pcase-let* ((origin (point))
               (`(,beg . ,end) (prelude-get-positions-of-line-or-region))
               (region (buffer-substring-no-properties beg end)))
    (-dotimes arg
      (lambda (n)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point))))
    (goto-char (+ origin (* (length region) arg) arg))))

(defun prelude-duplicate-and-comment-current-line-or-region (arg)
  "Duplicates and comments the current line or region ARG times.
If there's no region, the current line will be duplicated.  However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (pcase-let* ((origin (point))
               (`(,beg . ,end) (prelude-get-positions-of-line-or-region))
               (region (buffer-substring-no-properties beg end)))
    (comment-or-uncomment-region beg end)
    (setq end (line-end-position))
    (-dotimes arg
      (lambda (n)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point))))
    (goto-char (+ origin (* (length region) arg) arg))))

(defun prelude-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun jzn/duplicate-line (&optional commentfirst)
  "Duplicates the line at point; if COMMENTFIRST is non-nil, comment the original."
  (interactive "P")
  (beginning-of-line)
  (let ((beg (point)))
    (end-of-line)
    (let ((str (buffer-substring beg (point))))
      (when commentfirst
        (comment-region beg (point)))
      (insert-string
       (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
      (forward-line -1))))

(defun jzn/delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))
