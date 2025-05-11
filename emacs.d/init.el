;; UI
(setq inhibit-startup-message t)

;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)          ; Disable the menu bar
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq warning-minimum-level :emergency)

(blink-cursor-mode -1)

(setq custom-file "~/.config/emacs/custom-config.el")
(load-file "~/.config/emacs/custom-config.el")

;; cursor as line, temporary without evil
(setq-default cursor-type 'bar)

(setq ring-bell-function 'ignore) ; Disable bell

;; Match mac os title bar with color scheme
(when (memq window-system '(mac ns))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)) ; nil for dark text
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

;; Remove all from window titlebar
(setq frame-title-format nil)

;; space between lines
(setq-default line-spacing 3)
(setq-default truncate-lines t)

(fset 'yes-or-no-p 'y-or-n-p) ;; Quicker yes or no

;; Full size from startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
        doom-themes-enable-italic nil) ; if nil, italics is universally disabled
)

;; (load-theme 'doom-tokyo-night)
(load-theme 'doom-moonlight)
(setq modus-themes-mode-line '(borderless))
;; (load-theme 'modus-operandi-deuteranopia)
;;(load-theme 'modus-operandi-tinted)
(set-face-attribute 'default nil :font "Iosevka" :height 164);; :weight 'light) ;; :weight 'light)
;; (set-face-attribute 'default nil :font "Whois" :height 170)  ;;# no cyrilic :(

;; default, fixed-pitch(mono), variable-pitch
;; TODO: add variable
;; (set-face-attribute 'default nil :font "iA Writer Mono S" :height 150)
;; (set-face-attribute 'default nil :font "JetBrains Mono" :height 155);; :weight 'light)
;; (set-face-attribute 'default nil :font "Berkeley Mono" :height 160);; :weight 'light) ;; :weight 'light)
;; (set-face-attribute 'default nil :font "IBM Plex Mono" :height 155)
;; (set-face-attribute 'default nil :font "SF Mono" :height 150)

(set-face-bold-p 'bold nil)  ;; disable bold globaly, so maybe only for progmode
(mapc
 (lambda (face)
        (when (eq (face-attribute face :weight) 'bold)
          (set-face-attribute face nil :weight 'normal)))
 (face-list))

;; (setq mode-line-format nil) ; Hide status line, Does not work globaly
;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization a
;; and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
(require 'uniquify)

;;; Automatically insert closing parens
(electric-pair-mode t)

;;; Prefer spaces to tabs
(setq-default indent-tabs-mode nil)

;; Scrol like in vim
(setq scroll-step 1)
(setq scroll-margin 10)

;; Automatically save your place in files
(save-place-mode 1)

(setq ispell-program-name "aspell")

;; Save history in minibuffer to keep recent commands easily accessible
(savehist-mode t)

;; Keep track of open files
(recentf-mode t)

;; Keep files up-to-date when they change outside Emacs
(global-auto-revert-mode t)

;: Show count occurances in search
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq search-whitespace-regexp ".*?")

;; Display line numbers only when in programming modes
;; (add-hook 'prog-mode-hook 'display-line-numbers-mode) ;; Disable for now

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;; Icons 
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

;; Minibuffer completion is essential to your Emacs workflow and
;; Vertico is currently one of the best out there. There's a lot to
;; dive in here so I recommend checking out the documentation for more
;; details: https://elpa.gnu.org/packages/vertico.html. The short and
;; sweet of it is that you search for commands with "M-x do-thing" and
;; the minibuffer will show you a filterable list of matches.
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(basic substring partial-completion flex))
  :init
  (vertico-mode))

;; Improve the accessibility of Emacs documentation by placing
;; descriptions directly in your minibuffer. Give it a try:
;; "M-x find-file".
(use-package marginalia
  :after vertico
  :ensure t
  :init
  (marginalia-mode))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.2)
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :init
  (global-corfu-mode)
  ;; Enable optional extension modes:
  (corfu-history-mode)
  (corfu-popupinfo-mode))

;; A few more useful configurations...
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; Add extensions
(use-package cape
  :ensure t
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
  )

;;; EVIL section
(unless (package-installed-p 'evil)
  (package-install 'evil))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)

  (setq evil-want-minibuffer nil) ; messes with esc to quit
  (setq evil-kill-on-visual-paste nil)
  (setq evil-respect-visual-line-mode nil)
  (setq evil-symbol-word-search t)
  :bind (
    ("C-l" . evil-window-right)
    ("C-h" . evil-window-left)
    ("C-j" . evil-window-down)
    ("C-k" . evil-window-up)
  )
  :config
  (evil-set-undo-system 'undo-fu)
  (evil-mode 1))

;; add undo redo actions for C-u C-r
(use-package undo-fu
  :ensure t
  :defer t
  :bind (:map evil-normal-state-map
              ("u" . undo-fu-only-undo)
              ("C-r" . undo-fu-only-redo)))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (setq evil-collection-magit-want-horizontal-movement t)
  (setq evil-collection-magit-use-y-for-yank t)
  (evil-collection-init))


;; allow to use gg for comment lines
(use-package evil-commentary :ensure t :init)
(evil-commentary-mode)

;; (evil-define-key 'normal vterm-mode-map "k" ')
;;; END Evil section

;; Quit out of everything with esc, in default we need 3 time press esc
;; stolen from here https://github.com/meain/dotfiles/blob/7ee3c3006dd7fe6506c68bc09a0d3194d8ea7923/emacs/.config/emacs/init.el#L703
(defun my/keyboard-quit ()
  "Quit out of whatever."
  (interactive)
  ;; Delete frame if it is a minbuffer only popup
  (if (and (equal (cdr (assq 'name (frame-parameters))) "emacs-popup")
           (equal (cdr (assq 'minibuffer (frame-parameters))) 'only))
      (delete-frame))
  (keyboard-escape-quit)
  (minibuffer-keyboard-quit)
  (keyboard-quit))
(global-set-key [escape] 'my/keyboard-quit)

(defun my/insert-debug-stmt ()
  "Place breakpoint or binding.pry stmt by hotkey"
  (interactive)
  (if (equal major-mode 'ruby-mode)
      (insert "binding.pry"))
  (if (equal major-mode 'python-mode)
      (insert "breakpoint()"))
  (backward-char))

;; TODO: match word with _ as whole word (for search by start *)
(setq evil-symbol-word-search t)
(modify-syntax-entry ?_ "w")

;; emacs redo
(setq evil-undo-system "undo-redo")

;;Add paddings 
(use-package spacious-padding
 :ensure t
 :init
 (spacious-padding-mode))

(use-package vterm
  :defer t
  :ensure t
  :config
  :config (setq vterm-max-scrollback 100000)
  ;; :custom
  ;; (vterm-keymap-exceptions
  ;;  ;; vterm-default
  ;;  '("C-c" "C-x" "C-u" "C-g" "C-h" "C-l" "M-x" "M-o" "C-y" "M-y"
  ;;    ;; for use evil to move between windows
  ;;    "C-k" "C-j"))
  )
(use-package vterm-toggle
  ;; :defer t
  :ensure t
  :custom
  (vterm-toggle-scope 'project)
  (vterm-toggle-hide-method 'reset-window-configration)
  ;; :custom
  ;;  open on bottom
  ;; (setq vterm-toggle-fullscreen-p nil)
  ;; (add-to-list 'display-buffer-alist
  ;;   '((lambda (bufname _)
  ;;       (with-current-buffer bufname
  ;;           (equal major-mode 'vterm-mode)))
  ;;       (display-buffer-reuse-window display-buffer-at-bottom)
  ;;       (reusable-frames . visible)
  ;;       (window-height . 0.7)))
  )

;; toggle vterm at bottom
;; (setq vterm-toggle-fullscreen-p nil)
;; (add-to-list 'display-buffer-alist
;;     '((lambda (buffer-or-name _)
;;         (let ((buffer (get-buffer buffer-or-name)))
;;             (with-current-buffer buffer
;;             (or (equal major-mode 'vterm-mode)
;;                 (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
;;     (display-buffer-reuse-window display-buffer-in-side-window)
;;     (side . bottom)
;;     ;;(dedicated . t) ;dedicated is supported in emacs27
;;     (reusable-frames . visible)
;;     (window-height . 0.7)))
;;---

(global-set-key (kbd "s-j")  'vterm-toggle)
;; (vterm-timer-delay 0.01)

;; set PATH from env to emacs
(use-package exec-path-from-shell :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

 ;; active virtualenv for cur dir
(use-package pyvenv
  :ensure t
  :defer t
  :init)

(use-package yaml-mode
  :ensure 
  :defer t
  :init)

(use-package magit
  :ensure t
  :defer t
  :init)

;; Highlight uncommitted changes using VC
(use-package diff-hl
  :ensure t
  :defer 1
  :config
  ;; (diff-hl-flydiff-mode)
  (global-diff-hl-mode)
  (set-frame-parameter nil 'left-fringe 2)  ;; thin line
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode-unless-remote)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(setq magit-blame-echo-style 'headings) ;; in echo mode show git message under each line

(defun my/diff-hl-set-reference ()
  "Set the reference revision for showing diff-hl changes. Do so buffer-locally."
  (interactive)
  (setq-local
   diff-hl-reference-revision
   (read-string
    (format "Set reference revision (buffer %s): "
            (buffer-name))))
  (diff-hl-update))

(use-package gptel :ensure t :init)
(setq-default gptel-model 'qwen25coder32b20480 ;Pick your default model
              gptel-backend (gptel-make-azure "kontur-llm"
                              :host "srs-litellm.kontur.host"
                              :stream t
                              :endpoint "/v1/chat/completions"
                              :key gptel-api-key
                              :models '("qwen25coder32b20480")))

(defun get-project-root ()
  (when (fboundp 'projectile-project-root)
    (projectile-project-root)))

(defun copy-current-buffer-file-name ()
  "Get the relative file path from the project root."
  (interactive)
  (if buffer-file-name
      (let* ((project (project-current))
             (project-root (if project (project-root project)))
             (relative-path (if project-root
                                (file-relative-name buffer-file-name project-root)
                              nil)))
        (if relative-path
            (progn
              (message "Relative path from project root: %s" relative-path)
              (kill-new relative-path)) ; copy to the clipboard
          (message "File not in a project")))
    (message "Buffer is not visiting a file")))

;; Ripgrep the current word from project root
(defun consult-ripgrep-at-point ()
  (interactive)
  (consult-ripgrep (get-project-root)(thing-at-point 'symbol)))

(use-package zoom-window :ensure t :defer)

(use-package browse-at-remote
  :defer t
  :ensure t
  ;; :init (add-to-list 'browse-at-remote-remote-type-regexps '(:host "^git\\.skbkontur\\.ru$" :type "gitlab"))
  :general
  (:states '(normal visual)
   :keymaps 'override
   "SPC o r" 'browse-at-remote)
  )

;; (use-package browse-at-remote
;;   :general
;;   (:states '(normal visual)
;;    :prefix my-leader-key
;;    "gp" #'browse-at-remote
;;    )
;;   :config
;;   (setq browse-at-remote-prefer-symbolic nil)
;;   (add-to-list 'browse-at-remote-remote-type-regexps '(:host "^gitlab\\." :type "gitlab"))
;;   )

;; Embark stuff
(use-package embark
  :defer 1
  :ensure t
  :init (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (global-set-key (kbd "C-'")  'embark-act)
  (global-set-key (kbd "C-q")  'embark-export)
  (global-set-key (kbd "C-h B")  'embark-bindings))

(use-package embark-consult
  :ensure t
  :defer t
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;;;; Keybindings
(use-package general :ensure t)

(general-create-definer leader-spc
  :states 'motion
  :keymaps 'override
  :prefix "SPC")

(leader-spc
  "SPC" 'execute-extended-command
  "b" 'consult-buffer
  "f" 'consult-find
  "g" 'consult-ripgrep
  "s" 'consult-ripgrep-at-point
  "p" 'project-find-file
  "y" 'copy-current-buffer-file-name
  "r" 'xref-find-references
  "d" 'my/insert-debug-stmt
  )

;; Don't hightlight under cursor
(setq eglot-ignored-server-capabilites '(:documentHighlightProvider))
(setq eldoc-echo-area-use-multiline-p nil) ;; don't resize minibufer
(setq pixel-scroll-precision-mode-map 1) ;; smoth scroling for gui emacs
(setq x-select-enable-clipboard t) ;; enable copy to system clipboard
