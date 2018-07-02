;;; Package Archives
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
;;; Initialise all packages
(package-initialize)

;;; Start auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
;;; Start yasnippet
(require 'yasnippet)
;;; Start SrSpeedbar
(require 'sr-speedbar)

;;; Package --- Auto-Complete setup
(ac-config-default)
;;; Package --- Yasnippet setup
(yas-global-mode 1)
;;; Package --- SrSpeedbar setp
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 40)

;;; GDB many windows
(setq gdb-many-windows t
      gdb-show-main t)

;;; Font
(set-face-attribute 'default nil :font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 100)

(set-face-foreground 'font-lock-string-face "#1E9159") 
(set-face-foreground 'font-lock-comment-face "#B3B2B2") 
(set-face-foreground 'font-lock-function-name-face "#000000") 
(set-face-foreground 'font-lock-variable-name-face "#CD8CCF") 
(set-face-foreground 'font-lock-keyword-face "#0075D1") 
(set-face-foreground 'font-lock-type-face "#0075D1") 
(set-face-foreground 'font-lock-constant-face "#006506")
(set-face-foreground 'font-lock-warning-face "#FF8080") 

;;; Cursor
(setq-default cursor-type 'bar)
(set-cursor-color "#ffffff")

;;; Line numbers
(global-linum-mode t)

;;; Replace highlighted text
(delete-selection-mode 1)


;;; CODE

;;; Function to auto insert header guards in C/C++
(defun get-include-guard ()
  "Return a string suitable for use in a C/C++ include guard"
  (let* ((fname (buffer-file-name (current-buffer)))
         (fbasename (replace-regexp-in-string ".*/" "" fname))
         (inc-guard-base (replace-regexp-in-string "[.-]"
                                                   "_"
                                                   fbasename)))
    (concat (upcase inc-guard-base) "_")))

(add-hook 'find-file-not-found-hooks
          '(lambda ()
             (let ((file-name (buffer-file-name (current-buffer))))
               (when (string= ".h" (substring file-name -2))
                 (let ((include-guard (get-include-guard)))
                   (insert "#ifndef " include-guard)
                   (newline)
                   (insert "#define " include-guard)
                   (newline 4)
                   (insert "#endif")
                   (newline)
                   (previous-line 3)
                   (set-buffer-modified-p nil))))))


;;; .emacs ends here
