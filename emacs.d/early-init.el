;; UI
(setq inhibit-startup-message t)

;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)          ; Disable the menu bar
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips

;; make the window undecorated and round by default
(add-to-list 'default-frame-alist '(undecorated-round . t))

; this breaks modus-themes
; (setq package-enable-at-startup nil)

;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 1024 1024) gc-cons-percentage 0.1)
            (run-with-idle-timer 2 t (lambda () (garbage-collect)))))
