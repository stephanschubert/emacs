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
