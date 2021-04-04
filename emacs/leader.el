(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "b d"   'kill-buffer
  "w d"   'quit-window
  "f e"   'find-file
  "f d"   'my-open-dot-file
  "f w"   'my-open-repos
  "f r"   'my-load-dot-file
  "s"     'my-multi-term
  "g"     'magit
  "r"     'recentf-open-files
  "<tab>" 'mode-line-other-buffer

  "t"     'treemacs

  "p r"   'projectile-ripgrep
  "p f"   'projectile-find-file

  "c n"   'cargo-process-new

  "h n"   'hl-todo-next
  "h p"   'hl-todo-previous

  "l g g" 'lsp-find-definition
  "l g r" 'lsp-find-references
  "l r"   'lsp-rename
  "l b r" 'lsp-workspace-restart
  "l h"   'lsp-hover
  "l a"   'lsp-execute-code-action
  "l f"   'lsp-format-buffer
  "l l"   'lsp-lens-mode)
(evil-leader/set-key-for-mode
  'rust-mode
  "c a"   'cargo-process-add
  "c m"   'cargo-process-rm
  "c r d" 'cargo-process-run
  "c r r" 'my-cargo-process-run-release
  "c c"   'cargo-process-check
  "c f"   'cargo-process-fmt
  "c b"   'cargo-process-build
  "c t t" 'cargo-process-test
  "c t a" 'my-cargo-process-test)
(global-evil-leader-mode)
