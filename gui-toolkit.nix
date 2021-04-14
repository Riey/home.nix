{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome3.gnome_themes_standard;
      name = "Adwaita";
    };
    iconTheme = {
      name = "Adwaita";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "adwaita";
      package = pkgs.adwaita-qt;
    };
  };
}

