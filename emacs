(tool-bar-mode -1)

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

;; indent-guide
(require 'indent-guide)
(set-face-background 'indent-guide-face "dimgreen")
(setq indent-guide-delay 0.1)
(setq indent-guide-recursive t)


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
(set-face-background 'hl-line "#060606")
(set-face-foreground 'highlight nil)


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
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes
   (quote
    ("6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "bf25a2d5c2eddc36b2ee6fc0342201eb04ea090e637562c95b3b6e071216b524" default)))
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
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
 '(uniquify-buffer-name-style nil nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Oxygen-Sans" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))
