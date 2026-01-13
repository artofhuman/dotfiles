(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq warning-minimum-level :emergency)

;; Also, for mac os hide icon on middle of tittle bar
;; defaults write org.gnu.Emacs HideDocumentIcon YES

;; Don't blink cursor. Reduce distract
(blink-cursor-mode -1)

;; Save custom config to local file, not the end of init.el
(setq custom-file "~/.config/emacs/custom-config.el")
(load-file "~/.config/emacs/custom-config.el")

;; cursor as line, temporary without evil
(setq-default cursor-type 'bar)

;; Disable bell
(setq ring-bell-function 'ignore)

;; Match mac os title bar with color scheme
(when (memq window-system '(mac ns))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)) ; nil for dark text
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

;; Remove all from window titlebar
(setq frame-title-format nil)

;; space between lines
(setq-default line-spacing 3)
(setq-default truncate-lines t)

;; Quicker yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Unbind some default keybindings
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "C-<wheel-up>"))
(global-unset-key (kbd "C-<wheel-down>"))

;; Fullscreen size from startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; dont ask about safe theme when switch custom theme
(setq custom-safe-themes t)

;; disable custom theme on load new one
(defun disable-custom-themes (theme &optional no-confirm no-enable)
  (mapc 'disable-theme custom-enabled-themes))
(advice-add 'load-theme :before #'disable-custom-themes)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
        doom-themes-enable-italic nil) ; if nil, italics is universally disabled
)

(setq modus-themes-mode-line '(borderless)
      modus-themes-bold-constructs nil)
(load-theme 'modus-operandi-deuteranopia)

(set-face-attribute 'default nil :font "Iosevka" :height 155)
;; (set-face-attribute 'default nil :font "PragmataPro Mono Liga" :height 160)
;; (set-face-attribute 'default nil :font "Fragment Mono" :height 140);; :weight 'light) ;; :weight 'light)
;; (set-face-attribute 'default nil :font "Whois" :height 170)  ;;# no cyrilic :(
;; (set-face-attribute 'default nil :font "JetBrains Mono" :height 155);; :weight 'light)

(set-face-bold-p 'bold nil)  ;; disable bold globaly, so maybe only for progmode
(mapc
 (lambda (face)
        (when (eq (face-attribute face :weight) 'bold)
          (set-face-attribute face nil :weight 'normal)))
 (face-list))

;; (use-package mode-line-idle :ensure t :commands (mode-line-idle))

(defvar my/modeline-filename
  '(:eval (list (if (eq buffer-file-name nil) ""
                  (concat (file-name-nondirectory
                           (directory-file-name
                            (file-name-directory (buffer-file-name)))) "/"))
                (propertize "%b"
                            'face (if (buffer-modified-p)
                                      'font-lock-string-face
                                    'font-lock-builtin-face)
                            'help-echo (buffer-file-name)))))

(setq-default
  header-line-format
    (list
        ;; '(:eval (mode-line-idle 0.3 meain/modeline-project-color "░"))
        my/modeline-filename
        ;; '(:eval (mode-line-idle 1.0 meain/modeline-vcs ""))
        ;; '(:eval (mode-line-idle 1.0 meain/modeline-yap ""))
        ;; '(:eval (if (boundp 'keycast-mode-line) keycast-mode-line))
        'mode-line-format-right-align
        ;; '(:eval (if (boundp 'org-timer-mode-line-string) (concat org-timer-mode-line-string " ")))
        (propertize ":%l:%c ")
        (propertize "%p") ;; position in file, TODO: check it, does not works now
        (propertize " %m ")
        " "))

(setq-default mode-line-format nil)  ;; Hide status line

;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization a
;; and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;; Automatically insert closing parens
(electric-pair-mode t)

;;; Prefer spaces to tabs
(setq-default indent-tabs-mode nil)

;; Scrol like in vim
;; (setq scroll-step 1)
;; (setq scroll-margin 15)

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
;; (add-hook 'prog-mode-hook 'display-line-numbers-mode)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;; Icons 
;; (use-package all-the-icons
;;   :ensure t
;;   :if (display-graphic-p))

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

;; (use-package completion-preview
;;   :straight (:type built-in)
;;   :bind (:map completion-preview-active-mode-map
;;               ("M-n" . completion-preview-next-candidate)
;;               ("M-p" . completion-preview-prev-candidate))
;;   :init
;;   (global-completion-preview-mode 1))

(global-completion-preview-mode 1)

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
  (evil-mode 1)

  (evil-set-leader nil (kbd "<SPC>"))
  (define-key evil-normal-state-map (kbd "<leader>p") #'project-find-file)
  (define-key evil-normal-state-map (kbd "<leader><SPC>") #'execute-extended-command)
  (define-key evil-normal-state-map (kbd "<leader>b") #'consult-buffer)
  (define-key evil-normal-state-map (kbd "<leader>f") #'consult-find)
  (define-key evil-normal-state-map (kbd "<leader>g") #'consult-ripgrep)
  (define-key evil-normal-state-map (kbd "<leader>s") #'consult-ripgrep-at-point)
  (define-key evil-normal-state-map (kbd "<leader>r") #'xref-find-references)
  (define-key evil-normal-state-map (kbd "<leader>t g") #'magit)
  (define-key evil-normal-state-map (kbd "<leader>t b") #'magit-blame-echo)
  (define-key evil-normal-state-map (kbd "<leader>t h") #'diff-hl-show-hunk)
  (define-key evil-normal-state-map (kbd "<leader>y") #'my/copy-current-buffer-file-name)
  (define-key evil-normal-state-map (kbd "<leader>d") #'my/insert-debug-stmt)
  (define-key evil-normal-state-map (kbd "<leader>j j") #'my/jump-to-file-and-line)
  )

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
;;; END Evil section

;; === my func staff
;; https://karthinks.com/software/fringe-matters-finding-the-right-difference/
(defun my/diff-hl-set-reference ()
  "Set the reference revision for showing diff-hl changes.

Do so buffer-locally."
  (interactive)
  (setq-local
   diff-hl-reference-revision
   (read-string
    (format "Set reference revision (buffer %s): "
            (buffer-name))))
  (diff-hl-update))

(defun testrun-core--root ()
  "Get root directory for compilation.

This uses `project-current' to find the root directory of
the project and assumes that's the root for the compile command.
If `project-current' cannot find a project, returns the `default-directory'."
  (if-let ((project (project-current)))
      (project-root project)
    default-directory))

(defun testrun-core--file-name ()
  "Get the buffer filename relative to the compilation root."
  (file-relative-name buffer-file-name (testrun-core--root)))

(defun my/vterm-run-command (command)
  "Insert text of current line in vterm and execute."
  (interactive)
  (require 'vterm)
    (let ((buf (current-buffer)))
      (unless (get-buffer vterm-buffer-name)
        (vterm))
      (display-buffer vterm-buffer-name t)
      (switch-to-buffer-other-window vterm-buffer-name)
      (vterm--goto-line -1)
      (message command)
      (vterm-send-string command)
      (vterm-send-return)
      (switch-to-buffer-other-window buf)))

(defun my/vterm-toggle-run-pytest-current-file ()
  "Insert text of current line in vterm and execute."
  (interactive)
  (my/vterm-run-command (concat "pytest " (testrun-core--file-name))))

(global-set-key (kbd "C-c t")  'my/vterm-toggle-run-pytest-current-file)
  
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
  "Insert a debug statement appropriate for the major mode and indent the line."
  (interactive)
  (let ((debug-stmt
         (cond
          ((eq major-mode 'ruby-mode) "binding.pry")
          ((eq major-mode 'python-mode) "breakpoint()"))))
    (when debug-stmt
      (beginning-of-line)
      (open-line 1)
      (forward-line 1)
      (insert debug-stmt)
      (indent-according-to-mode))))

(defun my/get-project-root ()
  (when (fboundp 'projectile-project-root)
    (projectile-project-root)))

(defun my/copy-current-buffer-file-name ()
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

(defun my/close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun my/jump-to-file-and-line ()
  "Reads a line in the form FILENAME:LINE and, assuming a
relative path, opens that file in another window and jumps to the
line."
  (interactive)
  (let ((line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
    (string-match "\\(.*\\):\\([0-9]+\\)" line)
    (let ((file (match-string 1 line))
          (lnum (match-string 2 line)))
      (when (and file (file-exists-p (concat default-directory file)))
        (find-file-other-window (concat default-directory file))
        (and lnum (goto-line (string-to-number lnum)))))))

;; TODO: match word with _ as whole word (for search by start *)
(modify-syntax-entry ?_ "w")

;; emacs redo
(setq evil-undo-system "undo-redo")

;; Add paddings 
(use-package spacious-padding
 :ensure t
 :init
 :config
 (setq spacious-padding-widths
      '( :internal-border-width 7
         :header-line-width 2
         :mode-line-width 2
         :tab-width 0
         :right-divider-width 7
         :scroll-bar-width 0))
 (spacious-padding-mode))

(use-package vterm
  :defer t
  :ensure t
  :config
  ;; (setq vterm-max-scrollback 100000)
  (vterm-timer-delay 0))

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
  (set-frame-parameter nil 'left-fringe 3)  ;; thin line
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode-unless-remote)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(setq magit-blame-echo-style 'headings) ;; in echo mode show git message under each line

(use-package gptel :ensure t :init)
(setq-default gptel-model 'code-pro
              gptel-backend (gptel-make-azure "kontur-llm"
                              :host "srs-litellm.kontur.host"
                              :stream t
                              :endpoint "/v1/chat/completions"
                              :key gptel-api-key
                              :models '("code-pro")))

;; Ripgrep the current word from project root
(defun consult-ripgrep-at-point ()
  (interactive)
  (consult-ripgrep (my/get-project-root)(thing-at-point 'symbol)))

(use-package browse-at-remote
  :defer t
  :ensure t
  :config
  (add-to-list 'browse-at-remote-remote-type-regexps '(:host "^git\\.skbkontur\\.ru.*$" :type "gitlab")))
  :general
  (:states '(normal visual)
   :keymaps 'override
   "SPC o r" 'browse-at-remote))

(use-package consult
  :ensure t
  :after (xref evil)
  :defer t
  :config
  (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /\
      --smart-case --no-heading --line-number --hidden --follow --glob \"!.git/*\"")
  (setq xref-show-xrefs-function #'consult-xref)
  (setq xref-show-definitions-function #'consult-xref)
  (evil-set-command-property 'consult-imenu :jump t)
  :init
  (define-key evil-normal-state-map (kbd "<SPC> /") 'consult-line))

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

;; Don't highlight under cursor
(setq eglot-ignored-server-capabilites '(:documentHighlightProvider))
;; (setq eldoc-echo-area-use-multiline-p 1) ;; don't resize minibufer
(setq x-select-enable-clipboard t) ;; enable copy to system clipboard

(add-hook 'ruby-mode 'eglot-ensure)  ;; load lsp for riby on open rb files

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `((cperl-mode perl-mode) . ("/usr/local/bin/perlnavigator-server", "--stdio"))))

;; eldoc load
(use-package eldoc
  :defer t
  :after (evil)
  :config
  (setq eldoc-echo-area-use-multiline-p nil)
  (define-key evil-normal-state-map (kbd "K") 'eldoc-print-current-symbol-info)
  (global-eldoc-mode nil))

(use-package markdown-mode
  :ensure t
  :defer t)

;; Speed up eglot communication by translating to bycode externally
(use-package eglot-booster
  ;; :ensure t
  :after eglot
  :config
  (setq eglot-booster-io-only t)
  (eglot-booster-mode))

(use-package ultra-scroll
  ;:vc (:url "https://github.com/jdtsmith/ultra-scroll") ; if desired (emacs>=v30)
  :init
  ;; (setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
  ;;       scroll-margin 0)        ; important: scroll-margin>0 not yet supported
  :config
  (ultra-scroll-mode 1))

;; consult-eglot
(use-package consult-eglot
  :ensure t
  :commands (consult-eglot-symbols meain/imenu-or-eglot)
  :after (imenu eglot)
  :config
  :init
  (defun meain/imenu-or-eglot (&optional alternate)
    "Create a func to alternate between goto thingy stuff.
Giving it a name so that I can target it in vertico mode and make it use buffer."
    (interactive "P")
    (cond
     ((equal alternate nil) (consult-imenu))
     ((equal alternate '(4)) (consult-eglot-symbols))
      ((equal alternate '(16)) (tree-jump-search))
     ))
  (global-set-key (kbd "M-i") #'meain/imenu-or-eglot))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic partial-completion))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(setq org-confirm-babel-evaluate nil) ;; evalute without confirmation
(org-babel-do-load-languages
  'org-babel-load-languages
    '((python . t)))

(use-package typescript-mode
  :ensure t)

;; (use-package dtrt-indent
;;   :ensure t
;; :config

;; (dtrt-indent-mode 1))

;; sync buffers with file system
;; (global-auto-revert-mode t)
;; (setq global-auto-revert-non-file-buffers t)
