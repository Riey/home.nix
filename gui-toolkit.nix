{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc-Dark";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}

