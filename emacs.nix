{ pkgs, ... }:
let
  rycee-nur = (import (builtins.fetchTarball https://gitlab.com/rycee/nur-expressions/-/archive/master/nur-expressions-master.tar.gz) { pkgs = null; });
in
{
  imports = [ rycee-nur.hmModules.emacs-init ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
    overrides = self: super: {
      auctex = fetchTarball https://elpa.gnu.org/packages/auctex-13.0.6.tar;
    };
  };

  programs.emacs.init = {
    enable = true;
    recommendedGcSettings = true;
    startupTimer = true;
    earlyInit = builtins.readFile ./emacs/earlyInit.el;

    usePackage = {
      dracula-theme = {
        enable = true;
        config = "(load-theme 'dracula t)";
      };
      multi-term = {
        enable = true;
        config = "(setq multi-term-program /run/current-system/sw/bin/zsh)";
      };
      ansi-color = {
        enable = true;
        command = [ "ansi-color-apply-on-region" ];
      };
      golden-ratio = {
        enable = true;
        config = ''
          (setq golden-ratio-auto-scale t)
          (golden-ratio-mode t)
          (setq golden-ratio-extra-commands
                (append golden-ratio-extra-commands
                        '(evil-window-left
                          evil-window-right
                          evil-window-up
                          evil-window-down
                          buf-move-left
                          buf-move-right
                          buf-move-up
                          buf-move-down
                          window-number-select
                          select-window
                          select-window-1
                          select-window-2
                          select-window-3
                          select-window-4
                          select-window-5
                          select-window-6
                          select-window-7
                          select-window-8
                          select-window-9)))
        '';
      };

      which-key = {
        enable = true;
        config = ''
          (which-key-setup-side-window-right)
          (which-key-setup-minibuffer)
          (which-key-mode)
        '';
      };

      magit = {
        enable = true;
      };

      pinentry = {
        enable = true;
        config = ''
          (setq epa-pinentry-mode 'loopback)
          (pinentry-start)
        '';
      };

      ivy = {
        enable = true;
        config = "(ivy-mode 1)";
      };

      # evil
      evil = {
        enable = true;
        config = ''
          (setq evil-want-intgration t)
          (setq evil-want-minibuffer t)
          (setq evil-want-keybindings nil)
          (evil-mode 1)
        '';
      };
      evil-magit = {
        enable = true;
        after = [ "evil" ];
      };
      evil-collection = {
        enable = true;
        config = ''
          (evil-collection-init)
        '';
      };
      powerline-evil = {
        enable = true;
        config = "(powerline-evil-vim-color-theme)";
      };
      undo-tree = {
        enable = true;
        config = "(global-undo-tree-mode)";
      };
      undo-fu = {
        enable = false;
        config = ''
          (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
          (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)
          (global-unset-key (kbd "C-z"))
          (global-set-key (kbd "C-z")   'undo-fu-only-undo)
          (global-set-key (kbd "C-S-z") 'undo-fu-only-redo)
        '';
      };
      evil-leader = {
        enable = true;
        after = [ "evil" ];
        config = builtins.readFile ./emacs/leader.el;
      };

      # lsp
      lsp-mode = {
        enable = true;
        config = ''
          (setq lsp-eldoc-enable-hover t)
          (setq lsp-eldoc-render-all t)
          (setq lsp-auto-execute-action t)
          (setq lsp-diagnostic-package :flycheck)
          (setq lsp-enable-completion-at-point t)
          (setq lsp-enable-imenu t)
          (setq lsp-enable-indentation t)
          (setq lsp-enable-snippet t)
          (setq lsp-enable-semantic-highlighting t)
          (setq lsp-enable-symbol-highlighting t)
          (setq lsp-enable-text-document-color t)
          (setq lsp-enable-xref t)
          (setq lsp-prefer-capf t)
        '';
      };
      lsp-ui = {
        enable = true;
        hook = ["('lsp-mode . 'lsp-ui-mode)"];
        config = ''
          (setq lsp-ui-doc-enable t)
          (setq lsp-ui-peek-always-show t)
          (setq lsp-ui-sideline-show-code-actions t)
          (setq lsp-ui-sideline-show-diagnostics t)
          (setq lsp-ui-sideline-show-hover t)
          (setq lsp-ui-sideline-show-symbol t)
          (setq lsp-ui-sideline-ignore-duplicate t)
        '';
      };
      yasnippet = {
        enable = true;
        hook = ["('lsp-mode . 'yas-minor-mode-on)"];
      };

      # company
      company = {
        enable = true;
        hook = ["('prog-mode . 'global-company-mode)"];
        bindLocal = {
          company-mode-map = {
            "C-SPC" = "'company-complete-common";
          };
          company-active-map = {
            "C-l" = "'company-complete-selection";
            "<return>" = "'company-complete-selection";
            "C-h" = "'company-abort";
            "C-j" = "'company-select-next";
            "C-k" = "'company-select-previous";
            "<tab>" = "'company-complete-or-cycle";
          };
        };
        config = ''
          (push 'company-capf 'company-backends)
          (push 'company-elisp 'company-backends)
          (setq company-minimum-prefix-length 1)
          (setq company-idle-delay 0.0)
        '';
      };

      company-box = {
        enable = true;
        after = [ "company" ];
        hook = ["('company-mode . 'company-box-mode)"];
      };

      typescript-mode = {
        enable = true;
        mode = [''"\\.ts\\'"''];
      };

      rainbow-delimiters = {
        enable = true;
        hook = ["('prog-mode . 'rainbow-delimiters-mode)"];
      };

      all-the-icons = {
        enable = true;
        extraPackages = [ pkgs.emacs-all-the-icons-fonts ];
      };

      treemacs = {
        enable = true;
        extraPackages = [ pkgs.python3 ];
        config = ''
          (progn
          (setq treemacs-collapse-dirs (if treemacs-python-executable 3 0)
                treemacs-project-follow-cleanup t
                treemacs-workspace-switch-cleanup t)
          (treemacs-follow-mode t)
          (treemacs-fringe-indicator-mode t))
        '';
      };
      treemacs-evil = { after = ["treemacs" "evil"]; enable = true; };
      treemacs-projectile = { after = ["treemacs" "projectile"];  enable = true; };
      treemacs-magit = { after = ["treemacs" "magit"];  enable = true; };
      treemacs-icons-dired = { after = ["treemacs" "dired"];  enable = true; config = "(treemacs-icons-dired-mode)"; };

      dockerfile-mode = {
        enable = true;
        mode = [''"Dockerfile\\'"''];
      };

      yaml-mode = {
        enable = true;
        mode = [ ''"\\.\\(e?ya?\\|ra\\)ml\\'"'' ];
      };

      nix-mode = {
        enable = true;
        mode = [''"\\.nix\\'"''];
      };

      rust-mode = {
        enable = true;
        hook = ["('rust-mode . 'lsp)"];
        mode = [''"\\.rs\\'"''];
        config = ''
          (setq lsp-rust-analyzer-cargo-load-out-dirs-from-check t)
          (setq lsp-rust-analyzer-display-parameter-hints t)
          (setq lsp-rust-analyzer-proc-macro-enable t)
          (setq lsp-rust-analyzer-server-display-inlay-hints t)
        '';
      };

      flycheck = { enable = true; };
      flycheck-rust = { enable = true; hook = ["('rust-mode . 'flycheck-mode)"]; };

      cargo = {
        enable = true;
        hook = ["('rust-mode . 'cargo-minor-mode)"];
      };

      ripgrep = {
        enable = true;
        config = ''
          (setq ripgrep-executable "${pkgs.ripgrep}/bin/rg")
        '';
      };

      envrc = { enable = true; config = "(envrc-global-mode)"; };
      auctex = { enable = true; };
      pdf-tool = { enable = true; };
    };
  };
}

