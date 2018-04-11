(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "15348febfa2266c4def59a08ef2846f6032c0797f001d7b9148f30ace0d08bcf" "130319ab9b4f97439d1b8fd72345ab77b43301cf29dddc88edb01e2bc3aff1e7" "1c656eb3f6ae6c84ced46282cb4ed697bffe2f6c764bb5a737ed7ca6d068f798" "2cfc1cab46c0f5bae8017d3603ea1197be4f4fff8b9750d026d19f0b9e606fae" "c158c2a9f1c5fcf27598d313eec9f9dceadf131ccd10abc6448004b14984767c" default)))
 '(package-selected-packages
   (quote
    (hemera-theme hemisu-theme flatui-theme ## yaml-mode groovy-mode gradle-mode typescript-mode fiplr pylint json-mode json-snatcher json-reformat google-maps sr-speedbar reykjavik-theme madhat2r-theme leuven-theme green-phosphor-theme github-theme badwolf-theme afternoon-theme abyss-theme github-modern-theme scala-mode)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(my-carriage-return-face ((((class color)) (:foreground "yellow" :background "red"))) t)
 '(my-tab-face ((((class color)) (:foreground "white" :background "linen"))) t))

(set-default-font "Menlo 14")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq tab-width 4) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)

; add custom font locks to all buffers and all files
(add-hook
 'font-lock-mode-hook
 (function
  (lambda ()
    (setq
     font-lock-keywords
     (append
      font-lock-keywords
      '(
        ("\r" (0 'my-carriage-return-face t))
        ("\t" (0 'my-tab-face t))
        ))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; make characters after column 132 purple
(setq whitespace-line-column 132)

(setq whitespace-style
      (quote (face trailing tab-mark lines-tail)))
(add-hook 'find-file-hook 'whitespace-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set window widthxheight 132x80

(when window-system (set-frame-size (selected-frame) 132 70))
(add-to-list 'default-frame-alist '(height . 70))
(add-to-list 'default-frame-alist '(width . 132))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; transform literal tabs into a right-pointing triangle
(setq
whitespace-display-mappings ;http://ergoemacs.org/emacs/whitespace-mode.html
'(
   ;(tab-mark 9 [9654 9] [92 9])
   ;others substitutions...
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Turn on paren matching mode.
(show-paren-mode 1)

; Switch to matching paren when pressing % with cursor on source paren.
(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Untabify Buffer
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max))
  (if (not (eq major-mode 'mew-draft-mode))
      ;; delete-trailing-whitespace does not work in mew-draft-mode.
      (delete-trailing-whitespace)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Killing Buffers
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bookmarks
(require 'bookmark)
(setq bookmark-save-flag 1)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autosave the desktop layout every 15 seconds
(require 'desktop)
(desktop-save-mode 1)

(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)

(require 'saveplace)
(setq-default save-place t)

(setq history-length 1000)
(add-to-list 'desktop-globals-to-save 'file-name-history)

(setq desktop-buffers-not-to-save "^$")

(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

(desktop-read)
(setq desktop-save-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Third Party package installation. Melpa, Elpa.

(require 'package)
;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed
 'scala-mode)

(ensure-package-installed
 'fiplr)

(ensure-package-installed
 'gradle-mode)

(ensure-package-installed
 'groovy-mode)

(ensure-package-installed
 'yaml-mode)

;; activate installed packages
(package-initialize)

(ensure-package-installed 'markdown-mode)
(ensure-package-installed 'markdown-mode+)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fuzzy Finder
(global-set-key (kbd "C-x f") 'fiplr-find-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Styles, modes and themes.

(ensure-package-installed
 'abyss-theme
 'afternoon-theme
 'badwolf-theme
 'github-theme
 'green-phosphor-theme
 'leuven-theme
 'madhat2r-theme
 'reykjavik-theme
 'github-modern-theme
 'flatui-theme)

(package-initialize)
(load-theme 'github-modern t)

(setq-default indent-tabs-mode nil)

(load-file "~/.emacs.d/deepgrant-style.el")
(defun my-c++-mode-hook ()
  (c-set-style "deepgrant-style")
  (auto-fill-mode)
  (c-toggle-auto-newline 0)
  (c-toggle-auto-hungry-state 0))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c++-mode-hook)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.gcc\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.gxx\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utilities

(ensure-package-installed
 'sr-speedbar
 'google-maps
 'json-reformat
 'json-snatcher
 'json-mode
 'pylint
 'typescript-mode
 )

(package-initialize)

(setq typescript-indent-level 2)

(setq tramp-default-method "ssh")
