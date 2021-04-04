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
    # Enable Powerlevel10k instant prompt. Should stay close to the       top of ~/.zshrc.
    # Initialization code that may require console input (password p      rompts, [y/n]
    # confirmations, etc.) must go above this block; everything else       may go below.
    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi

    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
    '';
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    initExtra = "[[ ! -f ~/.config/nixpkgs/p10k.zsh ]] || source ~/.config/nixpkgs/p10k.zsh";
    sessionVariables = {
      GPG_TTY = "$(tty)";
    };
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
    };
  };

}

