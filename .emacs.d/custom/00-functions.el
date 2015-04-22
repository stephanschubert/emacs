(defun jzn/toggle-quotes ()
  "Toggle single quoted string to double or vice versa, and
  flip the internal quotes as well.  Best to run on the first
  character of the string."
  (interactive)
  (save-excursion
    (let ((start (nth 8 (syntax-ppss)))
          (quote-length 0) sub kind replacement)
      (goto-char start)
      (setq sub (buffer-substring start (progn (forward-sexp) (point)))
            kind (aref sub 0))
      (while (char-equal kind (aref sub 0))
        (setq sub (substring sub 1)
              quote-length (1+ quote-length)))
      (setq sub (substring sub 0 (- (length sub) quote-length)))
      (goto-char start)
      (delete-region start (+ start (* 2 quote-length) (length sub)))
      (setq kind (if (char-equal kind ?\") ?\' ?\"))
      (loop for i from 0
            for c across sub
            for slash = (char-equal c ?\\)
            then (if (and (not slash) (char-equal c ?\\)) t nil) do
            (unless slash
              (when (member c '(?\" ?\'))
                (aset sub i
                      (if (char-equal kind ?\") ?\' ?\")))))
      (setq replacement (make-string quote-length kind))
      (insert replacement sub replacement))))

(global-set-key (kbd "C-c C-t") 'jzn/toggle-quotes)

(defun jzn/newline-before-this-line ()
  (interactive)
  (beginning-of-line)
  (open-line 1)
  (funcall indent-line-function))

(global-set-key (kbd "M-o") 'jzn/newline-before-this-line)

;; See: http://emacs.stackexchange.com/questions/10359/delete-portion-of-isearch-string-that-does-not-match-or-last-char-if-complete-m
;; Alt: Use isearch+.el for more extensions.
(defun jzn/isearch-delete ()
  "Delete the failed portion of the search string, or the last char if successful."
  (interactive)
  (with-isearch-suspended
      (setq isearch-new-string
            (substring
             isearch-string 0 (or (isearch-fail-pos) (1- (length isearch-string))))
            isearch-new-message
            (mapconcat 'isearch-text-char-description isearch-new-string ""))))

(define-key isearch-mode-map (kbd "DEL") 'jzn/isearch-delete)
