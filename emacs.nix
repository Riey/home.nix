{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    #package = pkgs.emacsPgtkGcc;
    package = pkgs.emacsPgtk;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}

