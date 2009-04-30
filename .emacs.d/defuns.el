; For loading libraries from the vendor directory
(defun vendor (library)
	(let* ((file (symbol-name library))
				 (normal (concat "~/.emacs.d/vendor/" file))
				 (suffix (concat normal ".el")))
		(cond
		 ((file-directory-p normal) (add-to-list 'load-path normal) (require library))
		 ((file-directory-p suffix) (add-to-list 'load-path suffix) (require library))
		 ((file-exists-p suffix) (require library)))))

;
(defun rename-file-and-buffer (new-name)
 "Renames both current buffer and file it's visiting to NEW-NAME." (interactive "sNew name: ")
 (let ((name (buffer-name))
	(filename (buffer-file-name)))
 (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
 (if (get-buffer new-name)
	 (message "A buffer named '%s' already exists!" new-name)
	(progn 	 (rename-file name new-name 1) 	 
		 (rename-buffer new-name) 	 
		 (set-visited-file-name new-name) 	 
		 (set-buffer-modified-p nil))))))

;
(defun move-buffer-file (dir)
 "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
 (let* ((name (buffer-name))
	 (filename (buffer-file-name))
	 (dir
	 (if (string-match dir "\\(?:/\\|\\\\)$")
	 (substring dir 0 -1) dir))
	 (newname (concat dir "/" name)))

 (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
   (progn 	(copy-file filename newname 1) 	
		(delete-file filename) 	
		(set-visited-file-name newname) 	
		(set-buffer-modified-p nil) 	
		t)))) 
