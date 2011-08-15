(defun reload ()
  (interactive)
  (load "~/.emacs"))

;;custom keyboard bindings
(global-set-key (kbd "C-c C-a") 'reload)
(global-set-key (kbd "C-c C-v") 'comment-region)
(global-set-key (kbd "C-c C-x") 'uncomment-region)
(global-set-key (kbd "C-c C-n") 'cua-mode)

(add-hook 'python-mode-hook
          '(lambda () 
             (local-set-key (kbd "C-c C-p") 'python-switch-to-python)))

(setq compilation-scroll-output t)

(setq backup-directory-alist
      `((".*" . "~/.emacs-auto-save")))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(defun iden-newliner ()
  (interactive)
;;  (indent-according-to-mode)
  (newline-and-indent))
;;(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "RET") 'iden-newliner)

(global-font-lock-mode 1)

(mouse-wheel-mode t)

(setq c-default-style "bsd"
      c-basic-offset 4)

(setq column-number-mode t)

;;(set-background-color "black")
;;(set-foreground-color "white")

;;(set-face-foreground 'font-lock-comment-face "green")
;;(set-face-foreground 'font-lock-keyword-face "plum2")
(set-face-attribute 'default nil :height 125 :family "Courier New")

(setq-default indent-tabs-mode nil)
(setq c-indent-level 4)

(setq load-path (cons "~/.emacs-load-path" load-path))


;;espresso
;; (autoload #'espresso-mode "espresso" "Start espresso-mode" t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
;; (add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
;; (setq espresso-indent-level 4)

;;js2-mode 
;;(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  
;;(set-face-foreground 'font-lock-variable-name-face "Black")
;;(set-face-background 'font-lock-variable-name-face "White")
;;(set-face-foreground 'font-lock-string-face "LimeGreen")
;;(set-face-foreground 'font-lock-keyword-face "pink3")
;; (set-face-foreground 'font-lock-function-name-face "Navy")
;; (set-face-foreground 'font-lock-type-face "Red")


;; Begin stuff for silver

;; End stuff for silver

;;(load "~/python-emacs/doctest-mode.el")
;;(load "~/python-emacs/python-mode.el")
;;(load "~/sml-emacs/sml-mode-startup.el")
;;(load "~/prolog-emacs/prolog.el")


;;(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
;;(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;;(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
;;(setq prolog-system 'swi)
;;(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
;;				("\\.m$" . mercury-mode))
;;			      auto-mode-alist))

;;(load "~/emacs-el/javascript.el")
;;(autoload 'javascript-mode "javascript" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
;;(setq javascript-indent-level 2)

(setq mac-allow-anti-aliasing nil)

(require 'color-theme)
(load "color-theme-twilight.el")
(color-theme-twilight)

(require 'autopair)
(autopair-global-mode)
(autopair-mode t)

(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

(ido-mode)
