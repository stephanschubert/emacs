(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)

(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

;(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)

(defun* get-closest-gemfile-root (&optional (file "Gemfile"))
  "Determine the pathname of the first instance of FILE starting from the current directory
   towards root. This may not do the correct thing in presence of links. If it does not find FILE,
   then it shall return the name of FILE in the current directory, suitable for creation"
  (let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
    (loop
     for d = default-directory then (expand-file-name ".." d)
     if (file-exists-p (expand-file-name file d))
     return d
     if (equal d root)
     return nil)))

(require 'compile)

(defun rspec-compile-file ()
  (interactive)
  (compile (format "cd %s; bundle exec rspec %s"
                   (get-closest-gemfile-root)
                   (file-relative-name (buffer-file-name) (get-closest-gemfile-root))
                   ) t))

(defun rspec-compile-on-line ()
  (interactive)
  (compile (format "cd %s; bundle exec rspec %s -l %s"
                   (get-closest-gemfile-root)
                   (file-relative-name (buffer-file-name) (get-closest-gemfile-root))
                   (line-number-at-pos)
                   ) t))

(defun ruby-interpolate ()
  "In a double quoted string, interpolate."
  (interactive)
  (insert "#")
  (let ((properties (text-properties-at (point))))
    (when (and
           (memq 'font-lock-string-face properties)
           (save-excursion
             (ruby-forward-string "\"" (line-end-position) t)))
      (insert "{}")
      (backward-char 1))))

(defun ruby-reindent-then-newline-and-indent ()
	(interactive "*")
  (newline)
  (save-excursion
    (end-of-line 0)
    (indent-according-to-mode)
    (delete-region (point) (progn (skip-chars-backward " \t") (point))))
  (indent-according-to-mode))

;; Setup inf-ruby
;; (require 'inf-ruby)
;; (autoload 'run-ruby "inf-ruby"
;;           "Run an inferior Ruby process")

;; (autoload 'inf-ruby-keys "inf-ruby"
;;           "Set local key defs for inf-ruby in ruby-mode")

;; (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
;; (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)
;; (add-hook 'after-init-hook 'inf-ruby-switch-setup)

;; Setup rbenv w/ bundler
(require 'rbenv)
(global-rbenv-mode)

;; Setting rbenv path
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;; Setup robe mode for ruby w/ auto-complete support
(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode 'robe-ac-setup)

(add-hook 'enh-ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "enter") 'ruby-reindent-then-newline-and-indent)
            (local-set-key (kbd "C-c l") 'rspec-compile-on-line)
            (local-set-key (kbd "C-c k") 'rspec-compile-file)
            (local-set-key (kbd "#") 'ruby-interpolate)
            ))
