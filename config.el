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
(setq doom-theme 'catppuccin)

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
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 2)

; (set-company-backend! 'rust-mode '(company-lsp))
; (set-company-backend! 'prog-mode '(company-yasnippet company-lsp))

(map! :map company-active-map
      "TAB" #'company-complete-selection)

(use-package! lsp-ui
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'float)
  (setq lsp-ui-doc-max-width 120)
  (setq lsp-ui-doc-max-height 20))

;; lsp-ui-doc
; (add-hook 'lsp-mode-hook #'lsp-ui-doc-mode)
; (setq lsp-ui-doc-enable t)
; (setq lsp-ui-doc-position 'at-point)
; (setq lsp-ui-doc-alignment 'window)
; (setq lsp-ui-doc-delay 0.1)

; (add-hook 'rust-mode-hook
;   (lambda ()
;     (when (lsp-feature? :inlayHints)
;       (lsp-inlay-hints-mode 1))))

;; Integrating with cape
(use-package! cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-hook 'eglot-managed-mode-hook (lambda () (setq-local completion-at-point-functions (list (cape-capf-super #'eglot-completion-at-point)))))
)

;; Set up marginalia
(marginalia-mode t)

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
  
(use-package! rustic
  :config
  ;; 设置 rust-analyzer 路径（默认自动查找）
  (setq rustic-rustfmt-path "rustfmt")
  (setq rustic-cargo-path "cargo")
  (setq rustic-lsp-server 'rust-analyzer)  ; 明确指定 LSP 服务器
  ;; LSP 配置
  (add-hook 'rustic-mode-hook #'lsp-deferred))  ; 延迟启动 LSP
  

(setq lsp-idle-delay 0.5)
(setq lsp-completion-provider :capf)

;; Setup Ruff
;; (add-hook 'python-mode-hook #'flymake-ruff-load)

;; Setup auto-wrap
(add-hook! 'text-mode-hook #'visual-line-mode)

;; helix keybindings
;;(use-package helix                  
;;  :ensure t
;;  :config
;;  (helix-mode))
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
