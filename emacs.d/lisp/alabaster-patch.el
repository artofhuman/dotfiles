;;; alabaster-patch.el --- Match alabaster-themes to upstream Alabaster -*- lexical-binding: t; -*-

;;; Commentary:

;; The `alabaster-themes' port drifts from tonsky's originals: it colours what
;; the schemes leave plain, and skips the font-lock faces Emacs 29 added.
;; This restores the upstream look for both light variants.
;;
;; Upstream:
;;   https://github.com/tonsky/sublime-scheme-alabaster
;;   https://github.com/tonsky/zed-theme-alabaster

;;; Code:

(require 'treesit nil t)

;;;; Faces Emacs lacks

;; Emacs shares `font-lock-type-face' between class definitions and type
;; references; upstream colours only the definition (`entity.name').
(defface alabaster-definition
  '((t :inherit font-lock-type-face))
  "Definition names: upstream `entity.name'.")

;; Emacs gives `not' and `and' the same face as `if' and `return'.
(defface alabaster-operator
  '((t :inherit font-lock-keyword-face))
  "Word operators: upstream `keyword.operator'.")

;;;; Palette overrides, read by `load-theme'

;; Upstream leaves builtins, variable names and imports plain.
(defconst alabaster-patch-palette-overrides
  '((builtin      fg-main)
    (variable     fg-main)
    (preprocessor fg-main))
  "Palette entries both light variants share.")

(setq alabaster-themes-light-palette-overrides
      alabaster-patch-palette-overrides)

;; bg-hl-line is #f5f5f5 here; upstream line_highlight is #00000010 over white.
(setq alabaster-themes-light-bg-palette-overrides
      (cons '(bg-hl-line "#f0f0f0") alabaster-patch-palette-overrides))

;;;; Face specs

;; Gutter bars: added and modified sampled off a Sublime gutter running
;; Alabaster, since the scheme sets no `line_diff_*'. Deleted comes from Zed
;; Alabaster's `version_control.deleted'.
(defconst alabaster-patch-common-faces
  '((font-lock-number-face (:inherit font-lock-constant-face))
    ;; Definitions only, never call sites.
    (font-lock-function-call-face
     (:inherit unspecified :background unspecified :foreground "#000000"))
    (diff-hl-insert (:inherit unspecified :background unspecified :foreground "#6abf40"))
    (diff-hl-change (:inherit unspecified :background unspecified :foreground "#ec8013"))
    (diff-hl-delete (:inherit unspecified :background unspecified :foreground "#dd3f2e")))
  "Specs shared by both light variants.")

;; "Alabaster BG": syntax gets backgrounds, constants stay foreground-only.
;; Punctuation is #00000090 over white; `brackets_options' is underline alone,
;; so `brackets_foreground' colours the underline, not the bracket.
(defconst alabaster-patch-light-bg-faces
  '((font-lock-constant-face (:foreground "#7A3E9D" :background unspecified))
    (font-lock-escape-face
     (:inherit unspecified :background "#DBECB6" :foreground "#000000"))
    (font-lock-bracket-face (:foreground "#6f6f6f"))
    (font-lock-delimiter-face (:inherit unspecified :foreground "#6f6f6f"))
    (font-lock-punctuation-face (:foreground "#6f6f6f"))
    (font-lock-misc-punctuation-face (:inherit unspecified :foreground "#6f6f6f"))
    (font-lock-operator-face (:foreground "#6f6f6f"))
    (alabaster-operator (:inherit unspecified :foreground "#6f6f6f"))
    (font-lock-warning-face
     (:inherit unspecified :foreground "#cc3333" :background "#FFE0E0"))
    (alabaster-definition (:background "#DBF1FF" :foreground "#000000"))
    (show-paren-match
     (:inherit unspecified :background unspecified :foreground unspecified
      :underline "#007ACC")))
  "Specs for `alabaster-themes-light-bg'.")

;; "Alabaster": syntax gets foreground colours. The Punctuation rule covers
;; plain `punctuation' only, so operators stay black. Mistakes are red on red
;; at 20% over #F7F7F7. `brackets_options' is foreground and underline here.
(defconst alabaster-patch-light-faces
  '((font-lock-escape-face (:inherit unspecified :foreground "#777777"))
    (font-lock-bracket-face (:foreground "#777777"))
    (font-lock-delimiter-face (:inherit unspecified :foreground "#777777"))
    (font-lock-punctuation-face (:foreground "#777777"))
    (font-lock-misc-punctuation-face (:inherit unspecified :foreground "#777777"))
    (font-lock-warning-face
     (:inherit unspecified :foreground "#AA3731" :background "#E8D1CF"))
    (alabaster-definition
     (:inherit unspecified :foreground "#325CC0" :background unspecified))
    (show-paren-match
     (:inherit unspecified :background unspecified :foreground "#007ACC"
      :underline "#007ACC")))
  "Specs for `alabaster-themes-light'.")

(defconst alabaster-patch-themes
  '((alabaster-themes-light-bg . alabaster-patch-light-bg-faces)
    (alabaster-themes-light    . alabaster-patch-light-faces))
  "Theme to face-spec table.")

;;;; Applying

;; light-bg passes its own face list instead of the shared one, so it ships 89
;; of the theme's 502 faces: magit, org, dired, company and the rest go
;; untouched. Apply the shared list, then its own list on top.
(defun alabaster-patch--fill-light-bg ()
  "Give light-bg the faces it drops."
  (eval '(alabaster-themes-theme alabaster-themes-light-bg
                                 alabaster-themes-light-bg-palette
                                 alabaster-themes-light-bg-palette-overrides)
        t)
  (eval '(alabaster-themes-theme alabaster-themes-light-bg
                                 alabaster-themes-light-bg-palette
                                 alabaster-themes-light-bg-palette-overrides
                                 alabaster-bg-faces)
        t))

(defun alabaster-patch--apply (&rest _)
  "Re-apply the patch to whichever Alabaster theme is enabled."
  (pcase-dolist (`(,theme . ,specs) alabaster-patch-themes)
    (when (memq theme custom-enabled-themes)
      (when (eq theme 'alabaster-themes-light-bg)
        (alabaster-patch--fill-light-bg))
      (apply #'custom-theme-set-faces theme
             (mapcar (pcase-lambda (`(,face ,attrs))
                       (list face `((t ,attrs))))
                     (append alabaster-patch-common-faces
                             (symbol-value specs))))
      ;; Faces the theme never set are only recorded until it is re-enabled.
      (enable-theme theme))))

;; `load-theme' re-reads the theme file and wipes anything added afterwards.
(advice-add 'load-theme :after #'alabaster-patch--apply)

;;;; Definitions and word operators, via the parse tree

;; Brackets, delimiters and operators live on level 4; the default is 3.
(setq treesit-font-lock-level 4)

(defconst alabaster-patch-queries
  '((python . ((class_definition name: (identifier) @alabaster-definition)
               ["not" "and" "or" "in" "is"] @alabaster-operator))
    (ruby . ((class name: (constant) @alabaster-definition)
             (module name: (constant) @alabaster-definition)
             ["not" "and" "or"] @alabaster-operator))
    (typescript . ((class_declaration name: (type_identifier) @alabaster-definition)
                   (interface_declaration name: (type_identifier) @alabaster-definition)
                   (type_alias_declaration name: (type_identifier) @alabaster-definition)))
    (tsx . ((class_declaration name: (type_identifier) @alabaster-definition)
            (interface_declaration name: (type_identifier) @alabaster-definition)
            (type_alias_declaration name: (type_identifier) @alabaster-definition))))
  "Nodes to mark as definitions and word operators, per language.")

(defun alabaster-patch-fontify-definitions ()
  "Mark definitions and word operators in the current buffer."
  (when-let* ((lang (treesit-language-at (point-min)))
              (query (alist-get lang alabaster-patch-queries))
              ;; A grammar missing a node errors out here. Emacs 31 has
              ;; `treesit-query-with-optional' for this.
              (rules (ignore-errors
                       (treesit-font-lock-rules
                        :language lang
                        :feature 'alabaster-definition
                        :override t
                        query))))
    (setq-local treesit-font-lock-settings
                (append treesit-font-lock-settings rules))
    ;; Level 1 so the feature is on at any level; the rule still wins by
    ;; coming last in `treesit-font-lock-settings'.
    (setq-local treesit-font-lock-feature-list
                (let ((levels (copy-tree treesit-font-lock-feature-list)))
                  (setcar levels (append (car levels) '(alabaster-definition)))
                  levels))
    (treesit-font-lock-recompute-features)))

(dolist (hook '(python-ts-mode-hook ruby-ts-mode-hook
                typescript-ts-mode-hook tsx-ts-mode-hook))
  (add-hook hook #'alabaster-patch-fontify-definitions))

(provide 'alabaster-patch)
;;; alabaster-patch.el ends here
