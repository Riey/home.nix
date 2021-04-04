(setq comp-deferred-compilation t)
(setq package-native-compile t)
(prefer-coding-system 'utf-8)
(setq read-process-output-max (* 1024 1024))
(setq display-line-numbers-type 'relative)
(setq warning-minimum-level :emergency)
(global-display-line-numbers-mode)
(electric-pair-mode)
(recentf-mode 1)
(setq comint-move-point-for-output t)
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(defun my-multi-term()
  "Open multi-term on buttom"
  (interactive)
  (split-window-below)
  (other-window 1)
  (multi-term))

(defun my-cargo-process-run-release()
  "Run cargo run --relase"
  (interactive)
  (cargo-process--start "Run" "run --release"))

(defun my-cargo-process-test()
  "Run cargo test"
  (interactive)
  (cargo-process--start "Test" "test --all"))

(defun my-open-repos()
  (interactive)
  (dired "~/repos"))

(add-to-list 'default-frame-alist '(font . "Hack-14"))
(set-face-attribute 'default t :font "Hack-14")
(setq inhibit-startup-screen t)
(setq initial-major-mode 'fundamental-mode
      initial-scrath-message nil)

(setq use-package-always-ensure t)

