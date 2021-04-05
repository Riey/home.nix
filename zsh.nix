{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    plugins = [
      {
        name = "zsh-fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
      }
      {
        name = "zsh-powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
      }
    ];
    initExtraBeforeCompInit = ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
    '';
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    initExtra = ''
      [[ ! -f ~/.config/nixpkgs/p10k.zsh ]] || source ~/.config/nixpkgs/p10k.zsh
    '';
    shellGlobalAliases = {
      cat = "bat";
      ls = "lsd";
      l = "lsd -l";
      ll = "lsd -l";
      la = "lsd -a";
      lla = "lsd -la";
      lt = "lsd --tree";
      lta = "lsd -a --tree";
      ltl = "lsd -l --tree";
      ltla = "lsd -la --tree";
      nixsh = "nix-shell --command zsh";
    };
  };

}

