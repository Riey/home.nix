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
      fugitive
      vim-airline
      vim-airline-themes
      vim-css-color
      emmet-vim
      vim-nix
      vim-latex-live-preview
      latex-live-preview
      vim-toml
      syntastic
      coc-nvim
      coc-css
      coc-rust-analyzer
      nerdtree
      nerdtree-git-plugin
      auto-pairs
      rainbow
    ];
    extraConfig = builtins.readFile ./init.vim;
  };

  xdg.configFile."nvim/coc-settings.json".text = ''
  {
      "rust-analyzer.serverPath": "~/.nix-profile/bin/rust-analyzer"
  }
  '';
}

