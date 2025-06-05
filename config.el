;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-rouge)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Tofu characters solution
(when (display-graphic-p)
  (set-face-attribute 'default nil :font (font-spec :family "Maple Mono NF CN" :style "Italic" :size 24))
  (set-fontset-font t 'unicode "NotoColor Emoji" nil 'prepend))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; Set up company
;;(use-package company
;;  :hook (prog-mode . company-mode)
;;  :config
;;  (setq company-idle-delay 0.2
;;        company-minimum-prefix-length 2))

;;;; Setup corfu
(use-package! corfu
  :init
  (global-corfu-mode)    ;; Globally activate
  (corfu-history-mode)   ;; collect inputs of history
  (corfu-popupinfo-mode) ;; show detail info of the completion
  :config
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-prefix 2
        corfu-auto-delay 0.0
        corfu-popupinfo-delay 0.2
        corfu-sort-function #'corfu-sort-alpha))

;; Integrating with cape
(use-package! cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-hook 'eglot-managed-mode-hook (lambda () (setq-local completion-at-point-functions (list (cape-capf-super #'eglot-completion-at-point)))))
)

;; Setup shortcuts


;; Set up marginalia
(marginalia-mode t)

;; Set up orderless
(use-package orderless
  :config
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides nil))

;; Set up super-save
(use-package super-save
  :config
  (super-save-mode 1)
  (setq
   super-save-auto-save-when-idle t
   super-save-idle-duration 30
   super-save-remote-files nil
   super-save-triggers '(focus-out-hook switch-buffer-hook)))

;; Set up undo-fu
(use-package undo-fu
  :config
  (setq undo-limit 80000000))

;; Setup python lsp
(setenv "PATH" (concat (getenv "PATH") ":/run/current-system/sw/bin/"))
(after! lsp-mode
  (setq lsp-enabled-clients '(pyright))
  (setq lsp-disabled-clients '(pylsp mspyls)))

;; Setup Ruff
;; (add-hook 'python-mode-hook #'flymake-ruff-load)

;; Setup auto-wrap
(add-hook! 'text-mode-hook #'visual-line-mode)
(add-hook! 'text-mode-hook #'visual-line-mode)

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
