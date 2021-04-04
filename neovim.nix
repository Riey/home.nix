{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = dracula-vim;
        config = ''
          packadd! dracula-vim
          colorscheme dracula
        '';
      }
      vim-airline
      vim-airline-themes
      vim-nix
      vim-latex-live-preview
      latex-live-preview
      vim-toml
      syntastic
      coc-nvim
      coc-rust-analyzer
      nerdtree
      nerdtree-git-plugin
      auto-pairs
      rainbow
    ];
    extraConfig = builtins.readFile ./init.vim;
  };

  xdg.configFile."nvim/coc-settings.json".source = ./coc-settings.json;
}

