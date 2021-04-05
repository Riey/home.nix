{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  home.file.".emacs.d/init.el".source = ./.emacs.d/init.el;
}

