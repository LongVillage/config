;;;;;;;;;;;;;;;;;;
;; Environement ;;
;;;;;;;;;;;;;;;;;;


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "utf-8")
 '(custom-enabled-themes (quote (wombat)))
 '(default-input-method "utf-8")
 '(global-font-lock-mode t nil (font-lock))
 '(haskell-mode-hook (quote (turn-on-haskell-indent)) t)
 '(line-number-mode t)
 '(linum-format (quote "%d "))
 '(mouse-wheel-mode t nil (mwheel))
 '(package-selected-packages
   (quote
    (ein fill-column-indicator groovy-mode ess auctex ## auto-complete web-mode tuareg skype scala-mode2 rust-mode php-mode php+-mode merlin markdown-mode iedit haskell-mode erlang auto-complete-c-headers arduino-mode)))
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)

;;taille bordure
(setq-default left-fringe-width 2)
(setq-default right-fringe-width 2)

;;numéro de ligne
(global-linum-mode 1)

;;synchronisation des packets avec melpa
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Activation des downcase et upcase region
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Ne plus sauvegarder les fichier de backup dans le repertoire couvrant mais dans ~/.emacs.d/saves
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; Dossier contenant les script elisp
(add-to-list 'load-path "~/.emacs.d/elisp")

;; Utilisation de ido (meilleur navigation pour l'ouverture de fichier/ navigation entre les buffers
(require 'ido)
(ido-mode t)

;; configuration de auto-complete-mode
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)


;;;;;;;;;;;;;;;;
;; Raccourcis ;;
;;;;;;;;;;;;;;;;
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "M-TAB") 'auto-complete)
(global-set-key (kbd "C-x p") 'windmove-up)
(global-set-key (kbd "C-x ,") 'windmove-down)
(global-set-key (kbd "C-x e") 'windmove-right)
(global-set-key (kbd "C-x a") 'windmove-left)
;; Racourcie pour todotxt-mode

(global-set-key (kbd "C-c o") 'todotxt-open-file)
(global-set-key (kbd "C-c t") 'todotxt-add-todo)

;;;;;;;;;;
;; mode ;;
;;;;;;;;;;

;; Haskell
(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;;support de jsx dans web-mode
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; Python

(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (setq python-shell-interpreter "ipython"
       python-shell-interpreter-args "-i")
; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)
; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)


;; (setq ein:jupyter-default-server-command "/usr/local/bin/jupyter")
;; (setq ein:jupyter-server-args (list "--no-browser"))
;; (setq notebook-dir1 "~/")
;; (global-set-key (kbd "<f7>") '(lambda()
;; 				(interactive)
;; 				(ein:jupyter-server-start
;; 				 (executable-find
;; 				  "jupyter")
;; 				 notebook-dir1)))
;; (global-set-key (kbd "<f8>") '(lambda()
;; 				(interactive)
;; 				(ein:jupyter-server-stop)))

;; merlin
;; (push "/usr/share/emacs/site-lisp" load-path) ; directory containing merlin.el
;; (setq merlin-command "/usr/bin/ocamlmerlin")  ; needed only if ocamlmerlin not already in your PATH
;; (autoload 'merlin-mode "merlin" "Merlin mode" t)
;; (add-hook 'tuareg-mode-hook 'merlin-mode)
;; (add-hook 'caml-mode-hook 'merlin-mode)

;;.tuareg mode
(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode)
		("\\.eliom[i]$" . tuareg-mode))
	      auto-mode-alist))

;; C
(add-hook 'find-file-hook
          (lambda ()
            (when (string= (file-name-extension buffer-file-name) "c")
              (auto-complete-mode 1))))


;; gnuplot-mode
;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))
;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)
;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))
;; this line binds the function-9 key so that it opens a buffer into
;; gnuplot mode 
  (global-set-key [(f9)] 'gnuplot-make-buffer)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; todotxt-mode
(require 'todotxt-mode)
(setq todotxt-default-file (expand-file-name "~/Notes/Organisateur/todo.txt"))
;; LISTE DES MODES ;;
;; - todotxt-mode : major mode for editing todo.txt file : https://github.com/avillafiorita/todotxt-mode
