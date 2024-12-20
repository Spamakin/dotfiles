;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Anakin Dey"
      user-mail-address "anakin@icalyx.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
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
(setq doom-theme 'doom-one
      doom-font (font-spec :family "JuliaMono" :size 19))


(when (display-graphic-p)
  (custom-theme-set-faces! 'doom-one
    `(default :background "#1F2329")))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(straight-use-package 'org)


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
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;; 
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Load private things
(load! "priv.el")

;; Emacs now plays with the clipboard
(setq select-enable-clipboard t)

;; Custom splash image
(setq fancy-splash-image (concat doom-private-dir "cacochan.png"))

;; Remove shortcuts on splashscreen
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; Literate mode for agda go brrrrr
(add-to-list 'auto-mode-alist '("\\.lagda.md\\'" . agda2-mode))

;; Command to open vterm in a right window
(defun vterm/split-right ()
  "Create a new vterm window to the right of the current one."
  (interactive)
  (let* ((ignore-window-parameters t)
         (dedicated-p (window-dedicated-p)))
    (split-window-horizontally)
    (other-window 1)
    (+vterm/here default-directory)))

;; Command to open vterm in a left window
(defun vterm/split-left ()
  "Create a new vterm window to the left of the current one."
  (interactive)
  (let* ((ignore-window-parameters t)
         (dedicated-p (window-dedicated-p)))
    (split-window-horizontally)
    (+vterm/here default-directory)))

;; dired will kill buffers as you open directories
(setq dired-kill-when-opening-new-dired-buffer t)

;; Disable weird LaTeX sub/superscript rendering
(setq tex-fontify-script nil)
(setq font-latex-fontify-script nil)

(setq +latex-viewers '(okular))

(defface custom-latex-quest-face
  '((t :foreground "firebrick" :weight bold)) ; can add more properties
  "Face for highlighting \\quest{} in LaTeX."
  :group 'custom-faces)

(font-lock-add-keywords
 'LaTeX-mode
 '(("\\\\quest{.*?}" . 'custom-latex-quest-face)))

;; Grip for Markdown rendering
(setq grip-github-user "Spamakin")
(setq grip-update-after-change nil)

;; Modeline settings
(setq doom-modeline-buffer-file-name-style 'buffer-name)

;; Emacs indentation is god-awful to the point that we need an external config
(editorconfig-mode 1)

;; ;; GAP
;; (setq gap-executable "/home/spamakin/gap-4.13.0/gap")
