(tool-bar-mode -1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; No more typing the whole yes or no. Just y or n will do.
(fset 'yes-or-no-p 'y-or-n-p)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/"),
                         ("melpa" . "https://melpa.org/packages/")))

(require 'package)

(package-initialize)

;; cua-mode
(setq cua-enable-cua-keys nil)
(global-set-key (kbd "C-x r") 'cua-rectangle-mark-mode) 
(cua-mode t)

(when (fboundp 'windmove-default-keybindings)
    (windmove-default-keybindings))

(require 'goto-chg)

(global-set-key (kbd "M-<left>") 'goto-last-change)
(global-set-key (kbd "M-<right>") 'goto-last-change-reverse)

;; CEDET
(require 'cedet)
(semantic-mode 1)
(global-ede-mode 1)         
(global-semanticdb-minor-mode)
(global-semantic-highlight-func-mode)
(global-semantic-idle-local-symbol-highlight-mode)
(global-semantic-idle-scheduler-mode)
(global-semantic-idle-completions-mode)

;; flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-navigation-minimum-level nil)
(setq flycheck-checker-error-threshold nil)

;; Compile
(global-set-key (kbd "<f5>") 'compile)

;; Clang format
(load "~/.emacs.d/clang/clang-format.el")

;; sr-speedbar
(load "~/.emacs.d/elpa/sr-speedbar-0.1.8/sr-speedbar.el")
(require 'sr-speedbar)
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-max-width 60)
(setq sr-speedbar-default-width 40)
(global-set-key (kbd "C-x O") 'sr-speedbar-open) 
(global-set-key (kbd "C-x C") 'sr-speedbar-close) 
;;(sr-speedbar-open)

;; Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; indent-guide
(require 'indent-guide)
(set-face-background 'indent-guide-face "dimgreen")
(setq indent-guide-delay 0.1)
(setq indent-guide-recursive t)

;; YASnippet
(require 'yasnippet)
(setq yas/root-directory "~/emacs/snippets")
(yas/load-directory yas/root-directory)
(yas/minor-mode)
(yas/global-mode)

(add-hook 'c-mode-common-hook '(lambda ()
				 (add-to-list 'ac-omni-completion-sources (cons "\\." '(ac-source-semantic)))
				 (add-to-list 'ac-omni-completion-sources (cons "->" '(ac-source-semantic)))
				 (setq ac-sources '(ac-source-semantic ac-source-yasnippet))
				 ))

(add-hook 'c++-mode-common-hook '(lambda ()
				   (add-to-list 'ac-omni-completion-sources (cons "\\." '(ac-source-semantic)))
				   (add-to-list 'ac-omni-completion-sources (cons "->" '(ac-source-semantic)))
				   (setq ac-sources '(ac-source-semantic ac-source-yasnippet))
				   (setq flycheck-gcc-language-standard "c++11")
				   ))

;; auto-complete
(ac-config-default)

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
		       (if (not (minibufferp (current-buffer)))
			   (auto-complete-mode 1))
		       ))
(real-global-auto-complete-mode t)


;; global settings
(show-paren-mode 1)
(global-linum-mode t)
(setq linum-format "%d ")
(global-hl-line-mode 1)
;;(set-face-background 'hl-line "#060606")
;;(set-face-foreground 'highlight nil)

;; IDO
(require 'ido)
(ido-mode t)

;; LaTeX
(require 'tex)

;; AUCTeX
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-LaTeX-mode-setup () ; add ac-sources to default ac-sources
  (setq ac-sources
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
		ac-sources))
  )
(add-hook 'LaTeX-mode-hook 'ac-LaTeX-mode-setup)
(global-auto-complete-mode t)

(setq ac-math-unicode-in-math-p t)

;; PDF-LaTeX
(TeX-global-PDF-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   (vector "#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#002b36"))
 '(background-color "#002b36")
 '(background-mode dark)
 '(cua-mode t nil (cua-base))
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes
   (quote
    ("4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "e83c94a6bfab82536cef63610ec58d08dfddd27752d860763055daf58d028aad" "180adb18379d7720859b39124cb6a79b4225d28cef4bfcf4ae2702b199a274c8" "1177fe4645eb8db34ee151ce45518e47cc4595c3e72c55dc07df03ab353ad132" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "a301332a57e8de1b2996ee2d0b2439c18bd0cec9f8cc6ccaa73fac6e239462a8" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "bf25a2d5c2eddc36b2ee6fc0342201eb04ea090e637562c95b3b6e071216b524" default)))
 '(fci-rule-color "#073642")
 '(foreground-color "#839496")
 '(fringe-mode 10 nil (fringe))
 '(inhibit-startup-screen t)
 '(linum-format " %6d ")
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(red "#ffffff")
 '(safe-local-variable-values
   (quote
    ((quote
      (flycheck-gcc-include-path
       (list
	(expand-file-name
	 ("bii/deps"))))))))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(uniquify-buffer-name-style nil nil (uniquify))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Droid Sans Mono" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))
