;;; package --- Summary
;;; Commentary:
;;; Code:
(setq-default c-basic-offset 4)
(setq-default python-basic-offset 4)

;;; Emacs Package Manger stuff
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))



;;; Activating vim keybinds
(require 'evil)
(evil-mode 1)



;;; Visual stuff
(set-face-attribute 'default nil :height 110)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-linum-mode 1)

;;; Use Vim Keybinds to nagivate between windwos
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;;; Hiding the emacs splash screen
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;;; Stop interrupting the redraw process if there is user input
(setq redisplay-dont-pause t)

;;; Using IDO Mode to better navigate through buffers
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

(use-package material-theme
  :ensure
  :init
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
)

(use-package zenburn-theme
  :init
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
)
(load-theme 'material t)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("4528fb576178303ee89888e8126449341d463001cb38abe0015541eb798d8a23" default)))
 '(package-selected-packages
   (quote
    (erlang material-theme elpy zenburn-theme use-package helm-rtags flymake-cppcheck flycheck evil-visual-mark-mode company-rtags company-irony cmake-ide))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "#263238" :foreground "#a7adba")))))

(use-package flycheck
  :ensure t)

(add-hook 'after-init-hook #'global-flycheck-mode)
;;;(load "~/Programmieren/rtags/src/rtags.el")
(setq rtags-autostart-diagnostics t)


(use-package company-rtags
  :ensure
  :config (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))
	 
(use-package irony
  :ensure
  :config (add-hook 'c++-mode-hook 'irony-mode)
	    (add-hook 'c-mode-hook 'irony-mode))

(rtags-enable-standard-keybindings)


(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))


(use-package company-irony
  :ensure
  :config (add-to-list 'company-backends 'company-irony))

(setq company-backends (delete 'company-semantic company-backends))

(use-package elpy
  :ensure
  :config (add-hook 'python-mode 'elpy-enable))


(setq elpy-rpc-python-command "python3")
(elpy-use-cpython "/usr/bin/python3")

;;; define hooks
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(add-hook 'python-mode 'elpy-mode)

(add-hook 'erlang-mode-hook '(lambda() (setq indent-tabs-mode nil)))

;;; Loading auctex macros
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)

;;; .emacs ends here
