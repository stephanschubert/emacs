(add-to-list 'load-path "~/.emacs.d/vendor/ruby-mode")

(vendor 'ruby-mode)
(vendor 'ruby-hacks)
(vendor 'rdebug)

(eval-after-load 'ruby-mode
	'(progn
		 (add-hook 'ruby-mode-hook
							 '(lambda ()
                  (define-key ruby-mode-map (kbd "<return>") 'ruby-reindent-then-newline-and-indent)
                  (define-key ruby-mode-map "\C-c\C-d" 'rdebug)

									(require 'ruby-electric)
									(ruby-electric-mode t)

									(require 'ri)
									(local-set-key [f1] 'ri)

									(require 'ruby-compilation)
									(require 'inf-ruby)
									(inf-ruby-keys)))
))

;; FIXME!
;; Clear the compilation buffer between test runs.
;; (eval-after-load 'ruby-compilation
;;   '(progn
;;      (defadvice ruby-do-run-w/compilation (before kill-buffer (name cmdlist))
;;        (let ((comp-buffer-name (format "*%s*" name)))
;;          (when (get-buffer comp-buffer-name)
;;            (with-current-buffer comp-buffer-name
;;              (delete-region (point-min) (point-max))))))
;;      (ad-activate 'ruby-do-run-w/compilation)))

; These are all ruby files
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.sake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.html.ui$" . ruby-mode))

; We never want to edit Rubinius bytecode
(add-to-list 'completion-ignored-extensions ".rbc")

(defun ruby-reindent-then-newline-and-indent ()
	(interactive "*")
  (newline)
  (save-excursion
    (end-of-line 0)
    (indent-according-to-mode)
    (delete-region (point) (progn (skip-chars-backward " \t") (point))))
  (indent-according-to-mode))


; Rake support with completion (M-x rake) --------------------------------------

(defun pcomplete/rake ()
  "Completion rules for the `rake' command."
	(pcomplete-here (pcmpl-rake-tasks)))

(defun pcmpl-rake-tasks ()
	"Return a list of all the rake tasks defined in the current
   projects. I know this is a hack to put all the logic in the
   exec-to-string command, but it works and seems fast"
	(delq nil (mapcar '(lambda(line)
											 (if (string-match "rake \\([^ ]+\\)" line) (match-string 1 line)))
										(split-string (shell-command-to-string "rake -T") "[\n]"))))

(defun rake (task)
	(interactive (list (completing-read "Rake (default: default): "
																			(pcmpl-rake-tasks))))
	(shell-command-to-string (concat "rake " (if (= 0 (length task)) "default" task))))

; String interpolation ---------------------------------------------------------

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

(define-key ruby-mode-map (kbd "#") 'ruby-interpolate)
