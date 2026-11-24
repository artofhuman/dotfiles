;;; theme-sync.el --- Follow the terminal's light/dark theme -*- lexical-binding: t; -*-

;;; Commentary:

;; Terminal frames subscribe to DEC mode 2031. kitty (and tmux) then send
;; CSI ?997;1n (dark) or CSI ?997;2n (light) whenever the background changes.
;;
;; The handler sits on `CSI ?' itself and reads the rest by hand, like
;; `xterm--query' and kkp do: `?' is in `help-event-list', so a longer
;; decode-map key would turn into `describe-prefix-bindings' at the `?'.

;;; Code:

(defvar theme-sync-light 'alabaster-themes-light-bg "Theme for a light terminal.")
(defvar theme-sync-dark 'alabaster-themes-dark "Theme for a dark terminal.")

(defun theme-sync--apply (theme)
  "Enable THEME unless it is already on."
  (unless (memq theme custom-enabled-themes)
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme theme t)))

(defun theme-sync--csi-question (&optional _prompt)
  "Read a `CSI ?' reply; act on theme reports, swallow anything else."
  (let ((s "") ev)
    ;; Final byte of a CSI sequence is in @..~
    (while (and (setq ev (read-event nil nil 0.2))
                (if (characterp ev)
                    (progn (setq s (concat s (string ev)))
                           (not (<= ?@ ev ?~)))
                  (push ev unread-command-events)
                  nil)))
    (pcase s
      ("997;1n" (theme-sync--apply theme-sync-dark))
      ("997;2n" (theme-sync--apply theme-sync-light)))
    []))

(defun theme-sync--enable (&optional terminal)
  "Subscribe TERMINAL to theme notifications and ask for the current one."
  (unless (display-graphic-p terminal)
    (with-selected-frame (or (car (frames-on-display-list terminal))
                             (selected-frame))
      ;; A function here other than ours is a query in flight (kkp, xterm.el);
      ;; leave it, the advice below retries once it has run.
      (let ((cur (lookup-key input-decode-map "\e[?")))
        (when (and (or (null cur) (keymapp cur)
                       (eq cur #'theme-sync--csi-question))
                   (ignore-errors
                     (define-key input-decode-map "\e[?" #'theme-sync--csi-question)
                     t))
          (set-terminal-parameter nil 'theme-sync t)
          (send-string-to-terminal "\e[?2031h\e[?996n"))))))

(defun theme-sync--disable (&optional terminal)
  "Stop notifications on TERMINAL, so the shell does not get them."
  (when (and (terminal-live-p terminal)
             (terminal-parameter terminal 'theme-sync))
    (send-string-to-terminal "\e[?2031l" terminal)))

(defun theme-sync--disable-all ()
  (mapc #'theme-sync--disable (terminal-list)))

(defun theme-sync--reenable (&rest _)
  "Re-install after a query handler unbound `CSI ?'."
  (theme-sync--enable))

;; Their query handlers unbind `CSI ?' when done, ours included.
(with-eval-after-load 'kkp
  (advice-add 'kkp--terminal-setup :after #'theme-sync--reenable))
(with-eval-after-load 'term/xterm
  (advice-add 'xterm--primary-da-handler :after #'theme-sync--reenable))

;; Depth 90: run after kkp's hooks so its query is already in flight.
(add-hook 'tty-setup-hook #'theme-sync--enable 90)
(add-hook 'delete-terminal-functions #'theme-sync--disable)
(add-hook 'suspend-tty-functions #'theme-sync--disable)
(add-hook 'resume-tty-functions #'theme-sync--enable 90)
(add-hook 'suspend-hook #'theme-sync--disable-all)
(add-hook 'suspend-resume-hook #'theme-sync--enable 90)
(add-hook 'kill-emacs-hook #'theme-sync--disable-all)

(provide 'theme-sync)
;;; theme-sync.el ends here
