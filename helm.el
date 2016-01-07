;; Helm
(add-to-list 'load-path "~/.emacs.d/helm")
(add-to-list 'load-path "~/.emacs.d/emacs-async")
(require 'helm-config)
(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(global-set-key (kbd "C-x M-f") 'helm-do-grep-ag)
(global-set-key (kbd "C-x M-k") 'helm-find)
(global-set-key (kbd "M-x") 'helm-M-x)

;; Helm-git
(add-to-list 'load-path "~/.emacs.d/helm-ls-git")
(require 'helm-ls-git)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)

;; Helm-descbinds
(add-to-list 'load-path "~/.emacs.d/helm-descbinds")
(require 'helm-descbinds)
(helm-descbinds-mode)
