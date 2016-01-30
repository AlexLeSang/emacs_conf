(add-to-list 'load-path "~/.emacs.d/projectile")
(require 'projectile)

(add-hook 'cc-mode 'projectile-mode)
(add-hook 'c++-mode 'projectile-mode)
(add-hook 'python-mode 'projectile-mode)
(setq projectile-enable-caching t)
