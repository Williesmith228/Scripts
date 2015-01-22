;;设置loadpath
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(add-to-list 'load-path "~/.emacs.d/plugins/theme")
(add-to-list 'load-path' "~/.emacs.d/cl-lib/")
(require 'cl-lib)
;;设置为默认utf-8
(setq default-buffer-file-coding-system 'utf-8-unix)
;;关闭欢迎界面
(setq inhibit-startup-message t)
;;跳转到指定行
(define-key global-map "\M-x" 'goto-line)
;;主题
(require 'color-theme)
(color-theme-initialize)
;;模板
(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/plugins/yasnippet/snippets"
        ))
(yas-global-mode 1)

;;文件列表
(require 'sr-speedbar)

;;tabbar
(require 'tabbar)
(tabbar-mode 1)


;;自动补全
(require 'auto-complete-config)
(ac-config-default)
(auto-complete-mode t)

(tool-bar-mode 0)

;;自动补全括号
(require 'autopair)
(autopair-global-mode)

;;高亮括号
(require 'highlight-parentheses)
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (highlight-parentheses-mode)
             (setq autopair-handle-action-fns
                   (list 'autopair-default-handle-action
                         '(lambda (action pair pos-before)
                            (hl-paren-color-update))))))
(add-hook 'highlight-parentheses-mode-hook
          '(lambda ()
             (setq autopair-handle-action-fns
                   (append
		    (if autopair-handle-action-fns
			autopair-handle-action-fns
		      '(autopair-default-handle-action))
		    '((lambda (action pair pos-before)
			(hl-paren-color-update)))))))
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;;设置bookmark
(require 'bm)

;;非mac的中文字体
(set-fontset-font "fontset-default" 'gb18030' ("Microsoft YaHei" . "unicode-bmp"))
(when (eq system-type 'darwin)
  ;;设置一个MacOS字体
  (set-default-font " -apple-Monaco-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1")
  ;;干掉小方框！！因为上面那个万恶的字体没有草泥马的斜体！！！
  (set-fontset-font "fontset-default" 'gb18030' ("STHeiti" . "unicode-bmp"))
  )
;;设置一个屌逼的c风格的缩进
(setq c-basic-offset 4)

;;关掉默认的tab设置为4个空格
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
;;弄出来行号
(global-linum-mode t)
;;设置好左右匹配
(global-set-key [(meta left)] 'backward-sexp)
(global-set-key [(meta right)] 'forward-sexp)
;;M-g设置为gotoline
(global-set-key [(meta g)] 'goto-line)
;;设置注释区域
(defun my-comment-or-uncomment-region (beg end &optional arg)  
  (interactive (if (use-region-p)  
                   (list (region-beginning) (region-end) nil)  
                 (list (line-beginning-position)  
                       (line-beginning-position 2))))  
  (comment-or-uncomment-region beg end arg)  
  )  
(global-set-key [(control /)] 'my-comment-or-uncomment-region)

;;设置搜索时严格按照大小写
(setq-default case-fold-search nil)

;;设置搜索时高亮系那是全部
(setq search-highlight t)

;;设置替换时高亮显示
(setq query-replace-highlight t)
;;设置背景颜色
(set-background-color "#faf9de")
;;应该是行号之后空一条
(put 'upcase-region 'disabled nil)
;;set meta real meta
(when (eq system-type 'darwin)
 (setq mac-option-modifier 'meta)
 (setq mac-command-modifier 'control)
 (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
 )
;; ()的匹配
(show-paren-mode t)  
(setq show-paren-style 'parentheses)
;;光标移动到鼠标的时候把鼠标干掉！
(mouse-avoidance-mode 'animate)
;;设置光标为|而不是小黑块
(setq-default cursor-type 'bar)
;;设置打开ejs的时候默认使用html-mode
(
 setq auto-mode-alist
      ( append 
        '(("\\.ejs\\'" . html-mode)
          ("\\.s?html?\\'" . html-mode)
          (" \\.asp\\'" . html-helper-mode)
          ("\\.phtml\\'" . html-helper-mode)
          ("\\.css\\'" . css-mode)
          ("\\.pc$" . c-mode)
          )
        auto-mode-alist))

;;设置使用org模式打开.txt Orz....
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))
;;设置less文件用css方式打开
(add-to-list 'auto-mode-alist '("\\.less\\'" . css-mode
                                ))
;;设置gomode 自动打开
(require 'go-mode-autoloads)

;;设置bookmark的快捷键
(global-set-key [(control \`)] 'bm-toggle)
(global-set-key [(meta \`)]   'bm-next)

;;设置speedbar
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 20)
(setq speedbar-show-unknown-files t)
(global-set-key(kbd"<f5>")(lambda()
                            (interactive)
                            (sr-speedbar-toggle)
                            ))

;;设置开启的时候的大小（行数和列数）
(setq default-frame-alist 
      '((height . 35) (width . 100) )
      )
;;自动分屏
;;主屏幕设置为eshell
(eshell)
(rename-buffer "workplace")
(sr-speedbar-toggle)

;;tabbar hot key
(global-set-key [(meta j)] 'tabbar-backward)  
(global-set-key [(meta k)] 'tabbar-forward) 

(defun nb ()
  (interactive) 
  (other-window 1)
  )

(defun pb()
  (interactive) 
  (other-window -1)
  )

(global-set-key [(meta \[)] 'pb)  
(global-set-key [(meta \])] 'nb) 

;;shell config
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t) 
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

;;半透明
(global-set-key(kbd"<f6>") 'loop-alpha) ;;全局绑定F6键为Emacs半透明功能键
(setq alpha-list '((50 30) (100 100))) ;;当前窗口和非当前窗口时透明度分别为85、50
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab))))
     (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))))

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;;Gtags设置
(setq load-path (cons "~/.emacs.d/gtags/" load-path));;

(autoload 'gtags-mode "gtags" "" t) 
  
(setq c-mode-hook 
           '(lambda () 
               (gtags-mode 1) 
       )) 
  
(setq gtags-mode-hook 
       '(lambda () 
         (setq gtags-path-style 'absolute))) 

(add-hook 'c-mode-hook 
                 '(lambda () 
                             (gtags-mode 1)))

(add-hook 'c++-mode-hook 
                 '(lambda () 
                             (gtags-mode 1))) 

(add-hook 'gtags-mode-hook 
       (lambda() 
         (define-key gtags-mode-map (kbd "C-.") 'gtags-find-tag) 
         (define-key gtags-mode-map (kbd "C-, s") 'gtags-find-symbol) 
         (define-key gtags-mode-map (kbd "C-, u") 'gtags-pop-stack) 
         )) 
  
(add-hook 'gtags-select-mode-hook 
       (lambda () 
          (setq hl-line-face 'underline) 
          (hl-line-mode 1))) 
(add-hook 'gtags-select-mode-hook 
       (lambda() 
         (define-key gtags-select-mode-map (kbd "RET") 'gtags-select-tag) 
         )) 

