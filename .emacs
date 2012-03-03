(defun reload ()
  (interactive)
  (load "~/.emacs"))

(setq ring-bell-function 'ignore)

;;custom keyboard bindings
(global-set-key (kbd "C-c C-a") 'reload)
(global-set-key (kbd "C-c C-v") 'comment-region)
(global-set-key (kbd "C-c C-x") 'uncomment-region)
(global-set-key (kbd "C-c C-n") 'cua-mode)
(global-set-key (kbd "C-c C-r") 'rgrep)

(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-p") 'python-switch-to-python)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq compilation-scroll-output t)

(setq backup-directory-alist
      `((".*" . "~/.emacs-auto-save")))

(custom-set-variables
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))

(defun c-n-tab-indent (n)
  (interactive "nSize:")
  (setq c-default-style "linux"
        c-basic-offset n)
  (setq-default c-indent-level n)
  (setq-default indent-tabs-mode t)
  (setq default-tab-width n)
  )

(defun c-n-space-indent (n)
  (interactive "nSize:")
  (setq c-default-style "bsd"
        c-basic-offset n)
  (setq-default c-indent-level n)
  (setq-default indent-tabs-mode nil)
  )

(c-n-space-indent 4)

(global-set-key (kbd "RET") 'newline-and-indent)

(global-font-lock-mode 1)

(mouse-wheel-mode t)

(setq column-number-mode t)

(set-face-attribute 'default nil :height 125 :family "Courier New")

(setq load-path (cons "~/.emacs-load-path" load-path))

(setq mac-allow-anti-aliasing nil)

(require 'color-theme)
(load "color-theme-twilight.el")
(color-theme-twilight)

(require 'autopair)
(autopair-global-mode)
(autopair-mode t)

(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

(ido-mode)

(setq-default cursor-type '(bar . 1))

;; Markdown
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist
   (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

(defun markdown-custom()
  (set-fill-column 79)
  (auto-fill-mode t))

(add-hook 'markdown-mode-hook
          '(lambda () (markdown-custom)))

;; Go
(require 'go-mode-load)

;; Textmate
;;(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

