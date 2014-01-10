;; -*- coding: utf-8 -*-
;; -----------------------------------------------------------------------------
;; ZHUO Qiang's Emacs Configuration
;; Extended by Nilom, 2014 
;; -----------------------------------------------------------------------------

;; (setq debug-on-error t)

(when (not (equal window-system 'w32))
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  (setq exec-path (append exec-path '("/usr/local/bin"))))

;; add load path
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory "~/.emacs.d/"
    "default user emacs directory"))

(defun qiang-in-emacs-directory (path)
  (concat user-emacs-directory (convert-standard-filename path)))

(let ((default-directory 
        (qiang-in-emacs-directory "lisp")))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(load-library "qiang")

(qiang-set-font
 '("Consolas" "DejaVu Sans Mono" "Monospace" "Courier New")
 '("Microsoft Yahei" "STHeiti" "hei" "文泉驿等宽微米黑" "新宋体" "宋体"))

(setq text-scale-mode-step 1.1)
;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(setq delete-by-moving-to-trash t)
(when (eq system-type 'darwin)
  (setq trash-directory "~/.Trash/emacs")
  ;; (setq mac-option-modifier 'hyper) ; Option key as Hyper
  ;; (setq mac-option-modifier 'super) ; Option key as Super
  ;; (setq mac-control-modifier 'ctrl) ; Control key as Ctrl
  (setq mac-command-modifier 'meta) ; Command key as Meta
  (setq ns-pop-up-frames nil); open file in current frame
  (global-set-key (kbd "<s-wheel-up>") 'text-scale-increase)
  (global-set-key (kbd "<s-wheel-down>") 'text-scale-decrease)
  )


;; It is default now since Emacs 24
;; (setq x-select-enable-clipboard t)
;; (setq interprogram-paste-function 'x-selection-value)
(if (functionp 'tool-bar-mode) (tool-bar-mode 0))
(setq-default buffer-file-coding-system 'utf-8-unix)
(setq frame-title-format "%f %4 %b %Z %* %10 %I")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(column-number-mode t)
;; 显示列号
(setq column-number-mode t)
(setq line-number-mode t)
(global-linum-mode t)

;;去掉工具栏
(tool-bar-mode nil)
;;去掉菜单栏，我将F10绑定为显示菜单栏，万一什么东西忘了，需要菜单栏了可以摁F10调出，再摁F10就去掉菜单
(menu-bar-mode nil)
;;不要滚动栏，现在都用滚轴鼠标了，可以不用滚动栏了
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
;;改变emacs标题栏的标题
(setq frame-title-format "%b@Nilom-Emacs")
;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)
;;鼠标自动避开指针，如当你输入的时候，指针到了鼠标的位置，鼠标有点挡住视线了
(mouse-avoidance-mode 'animate)

;; For Org mode by Nilom.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-agenda-files (list "~/Org/momento.org"))

;设置Mobile-org目录
(setq org-mobile-directory "~/MobileOrg")

;; 将一个条目标记完成之后，添加时间戳和note
(setq org-log-done 'time)
(setq org-log-done 'note)

;; 去除页脚信息
(setq org-export-html-postamble nil)

(defcustom org-export-html-style "<link rel=\"stylesheet\" type=\"text/css\"
href=\"~/.emacs.d/org-mode-snapshot.css\">" "" :group 'org-export-html :type 'string)

(setq display-time-day-and-date t)
(display-time-mode t)
(setq show-paren-style 'parentheses)
(show-paren-mode t)
(when window-system
  (require 'hl-line+)
  (toggle-hl-line-when-idle t))

(fset 'yes-or-no-p 'y-or-n-p)
(setq x-stretch-cursor t) ; Stretch the cursor on TABs.
(setq-default comint-process-echoes t) ;Do not echo the input in shell.
(setq-default next-line-add-newlines nil)
(setq visible-bell t)
(setq enable-recursive-minibuffers t)
(setq scroll-margin 5
      scroll-conservatively 1000)


;; Chinese sentence
(setq sentence-end
      "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*") 
(setq sentence-end-double-space nil)

(desktop-save-mode t)
(setq desktop-dirname user-emacs-directory)
(setq desktop-path `(,user-emacs-directory))
(setq desktop-restore-eager 5)

(if (functionp 'electric-pair-mode) (electric-pair-mode 1))

(setq ido-save-directory-list-file (qiang-in-emacs-directory "ido.last"))
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-file-extensions-order
      '(".org" ".txt" ".py" ".h" ".cpp" ".c" ".hpp" 
        ".emacs" ".xml" ".el" ".ini" ".cfg" ".java"))
(ido-mode t)
(setq ido-ignore-extensions t)
(setq ido-slow-ftp-host-regexps '(".*"))
(setq ido-work-directory-list-ignore-regexps '(".*"))
(add-to-list 'ido-ignore-files "\\.DS_Store")

(setq bookmark-save-flag 1)
(setq kill-whole-line t)

(global-set-key [(meta g)] 'goto-line)
(global-set-key [(f5)] 'compile)
(global-set-key (kbd "<C-f5>") 'revert-buffer)
(global-set-key [(f8)] 'next-error)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "C-S-o") 'qiang-open-next-line)
(global-set-key (kbd "C-o") 'qiang-open-previous-line)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol)) 
(global-set-key (kbd "M-/") 'hippie-expand)

(icomplete-mode 1)

(setq backup-directory-alist 
      `((".*" . ,(qiang-in-emacs-directory "backup"))))
(setq auto-save-file-name-transforms 
      `((".*" ,(qiang-in-emacs-directory "auto-save") t)))

(eval-after-load "compile"
  '(progn
     (setq-default compile-command "scons -u ")
     (add-to-list 'compilation-error-regexp-alist 
                  '("^ *File \"\\([^,\" \n\t]+\\)\", line \\([0-9]+\\)" 1 2))
     (add-to-list 'compilation-error-regexp-alist 
                  '("^\\(.*\\)(\\([0-9]+\\)):" 1 2))))

(global-set-key "\M-;" 'qiang-comment-dwim-line)
(global-set-key "\C-cR" 'qiang-rename-current-file-or-buffer)

;; auto re-format when pasting code
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice, command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode lisp-mode clojure-mode scheme-mode
                                     haskell-mode ruby-mode rspec-mode
                                     c-mode c++-mode objc-mode nxml-mode
                                     latex-mode js-mode plain-tex-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))

(global-set-key (kbd "M-k") 'qiang-copy-line)

;; fix server unsafe error under windows
(require 'server)
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t))

(if window-system (server-mode 1))

;; Emacs-List Mode
(define-key emacs-lisp-mode-map [(f5)] 'eval-buffer)

;; CC Mode
(c-add-style
 "qiang"
 '("bsd"
   (indent-tabs-mode . nil)
   (c-basic-offset . 4)))

(add-hook
 'c-mode-common-hook '
 (lambda ()
   (c-set-style "qiang")
   (auto-fill-mode)
   ;; (c-toggle-auto-newline)
   (c-toggle-auto-hungry-state)))

(setq
 auto-mode-alist 
 (append
  '(("\\.\\(vsh\\|fsh\\|c\\)$" . c-mode)
    ("\\.\\(cpp|\\cxx\\|h\\|hpp\\|hxx\\|cc\\|dox\\|mm\\|hmm\\)$" . c++-mode)
    ("\\.\\(m\\|mm\\)$" . objc-mode))
    auto-mode-alist))

;; Java
(add-hook
 'java-mode-hook '
 (lambda ()
   (c-set-style "java")
   (auto-fill-mode)
   (c-toggle-auto-hungry-state t)))

(add-hook 'find-file-hook 'qiang-choose-header-mode)

;; hexl Mode
(setq auto-mode-alist
      (cons '("\\.\\(exe\\|dll\\|so\\|o\\)$" . hexl-mode)
            auto-mode-alist))


;; python Mode
(setq auto-mode-alist
      (cons '("\\(\\.py?w\\)\\|\\(sconscript\\)\\|\\(sconstruct\\)\\|\\(SConstruct\\)\\|\\(SConscript\\)$" . python-mode)
            auto-mode-alist))


;; Lua Mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))


;; Shell Mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; nXML Mode
(setq
 auto-mode-alist 
 (cons '("\\.\\(xml\\|html\\|zcml\\)" . nxml-mode)
       auto-mode-alist))
(add-hook
 'nxml-mode-hook 
 (lambda () (define-key nxml-mode-map (kbd "C-c v") 'browse-url-of-buffer)))

(setq nxml-slash-auto-complete-flag t)
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files (qiang-in-emacs-directory "lisp/html5-el/schemas.xml")))
(require 'whattf-dt)

;; Markdown Mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))


;; Org Mode
(setq org-startup-truncated nil)

(require 'yasnippet) 
(yas-global-mode 1)
(when (not window-system)
  (setq-default yas-trigger-key "TAB"))
(setq yas-also-auto-indent-first-line t)

;; (require 'ahg)

;; (if (and (boundp 'custom-theme-load-path) t)
;;     (progn
;;       (add-to-list 'custom-theme-load-path (qiang-in-emacs-directory "themes"))
;;       ;; (load-theme 'manoj-dark t)
;;       (load-theme 'zenburn t)
;;       )
;;   (progn
;;     (require 'color-theme)
;;     (eval-after-load "color-theme"
;;       (if window-system
;;           '(progn
;;              (color-theme-initialize)
;;              (load "color-theme-blackboard")
;;              (color-theme-blackboard))))))

(require 'quick-jump)
(quick-jump-default-keybinding)

(require 'breadcrumb)
(global-set-key [(control f2)] 'bc-set)
(global-set-key [(f2)] 'bc-previous)
(global-set-key [(shift f2)] 'bc-next)
(global-set-key [(meta f2)] 'bc-list)

(global-set-key "\C-ci" 'qiang-ido-imenu-symbol)

(when window-system
  (if (eq system-type 'windows-nt)
      (w32-send-sys-command 61488)
    (progn
      (require 'frame-cmds)
      (maximize-frame))))

(auto-insert-mode 1)
(setq auto-insert-alist '()) ; clear build-in insert templates
(qiang-define-auto-insert "\\.\\(h\\|hpp\\|hxx\\|hmm\\)$" "h")
(qiang-define-auto-insert "\\.\\(html\\)" "html5")
(qiang-define-auto-insert "\\.\\(rst\\)" "h")
(qiang-define-auto-insert "\\.\\(py\\|pyw\\)$" "h")
(setq auto-insert-query nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#000" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(background-color "#002b36")
 '(background-mode dark)
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes (quote ("d737a2131d5ac01c0b2b944e0d2cb0be1c76496bb4ed61be51ff0e5457468974" "bf3ec301ea82ab546efb39c2fdd4412d1188c7382ff3bbadd74a8ecae4121678" "16905cf6154d53610ac3525eb8eaa23186d03a00e3f1e965cb15bb075d5dc384" default)))
 '(fci-rule-color "#383838")
 '(foreground-color "#839496")
 '(org-agenda-files (quote ("~/Org/momento.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "white" :background "#0078ba" :box nil))))
 '(mode-line-inactive ((t (:foreground "white" :background "#262626" :box nil)))))

;; Disable scroll bar.
;; by Nilom.
(toggle-scroll-bar -1)

;; for powerline
;; desc: powerline
;; mode:  emacs-powerline
;; link: https://github.com/jonathanchu/emacs-powerline
;; -----------------------
(add-to-list 'load-path "~/.emacs.d/vendor")
(require 'powerline)

(defun graphic-powerline-config ()
  "powerline setting for graphic"
  (interactive)
  (progn
    (setq powerline-arrow-shape 'arrow)
    (custom-set-faces
     '(mode-line ((t (:foreground "white" :background "#0078ba" :box nil))))
     '(mode-line-inactive ((t (:foreground "white" :background "#262626" :box nil))))
     )
    (setq powerline-color1 "#0088cc")
    (setq powerline-color2 "white")
    )
  )

(defun terminal-powerline-config()
  " powerline setting for terminal"
  (interactive)
  (setq powerline-arrow-shape 'arrow)
  (setq powerline-color1 "grey22")
  (setq powerline-color2 "grey22") 
  (custom-set-faces
   '(mode-line ((t (:foreground "grey44" :background "grey22" :box nil))))
   '(mode-line-inactive ((t (:foreground "grey22" :background "grey44" :box nil))))
   ))

  "根据是否图形界面加载配置"
(if (display-graphic-p)
    (graphic-powerline-config)
  (terminal-powerline-config))
(powerline-default)



;; 使用%来匹配括号，和vi一样。
(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
;; end [] match

;; NILOM's Persional theme settings.
;(load-file "~/.emacs.d/vendor/color-theme-heroku/color-theme-heroku.el")
;(color-theme-heroku)
(load-file "~/.emacs.d/vendor/color-theme-molokai/color-theme-molokai.el")
(color-theme-molokai)
;(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor")
;(molokai)


;; DIR Tree view
;; By NILOM
;; From stackoverflow
;; (add-to-list 'load-path "~/.emacs.d/lisp")
(require 'dirtree)
(require 'tree-mode)
(require 'windata)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
(global-set-key "\C-o" 'dirtree-show)

;; Speedbar Setting
;; By NILOM
(require 'sr-speedbar)

;; set htmlize
(require 'htmlize)
;; Org-mode 生成HTML保持代码高亮。
(setq org-src-fontify-natively t)
;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (emacs-lisp . t)
   (sh . t)
   (perl . t)
   (python .t)
   (ditaa . t)
   ))
;; set ditta path
(setq org-ditaa-jar-path "c:/ditaa.jar")

; For PHP Mode.
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))
