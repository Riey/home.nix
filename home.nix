{ config, pkgs, lib, ... }:

let
  kime = import ~/repos/kime/default.nix {};
  # kime = import ./pkgs/kime.nix { pkgs = pkgs; };

  gtk3_cache = pkgs.runCommand "gtk3-immodule.cache"
  { preferredLocalBuild = true;
    allowedSubstitutes = false;
    buildInputs = [ pkgs.gtk3 kime ];
  }
  ''
    mkdir -p $out/etc/gtk-3.0/
    GTK_PATH=${kime}/lib/gtk-3.0/ gtk-query-immodules-3.0 > $out/etc/gtk-3.0/immodules.cache
  '';
in
{
  imports = [
    ./emacs.nix
    ./sway.nix
    ./neovim.nix
    ./gui-toolkit.nix
    ./tool.nix
    ./zsh.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "riey";
  home.homeDirectory = "/home/riey";
  home.sessionVariables = {
    EDITOR = "nvim";
    GPG_TTY = "$(tty)";
    # PAGER = "rp";
    LESSCHARSET = "utf-8";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];

  home.packages = with pkgs; [
    cachix nix-index
    nload nodejs neofetch
    ripgrep lsd fd bat dua
    cargo-edit cargo-outdated
    gcc rustc cargo rust-analyzer rustfmt

    breeze-gtk
    breeze-icons
    breeze-qt5

    gitAndTools.gh

    # torrent
    transmission-gtk

    # video
    vlc ffmpeg rclone youtube-dl
    vapoursynth
    vapoursynth-mvtools
    ffms

    # file
    feh unzip p7zip
    xdg_utils

    # TeX
    texlive.combined.scheme-full
    evince

    # gui apps
    imagemagick7
    swaylock
    swayidle
    swaybg
    waybar
    wl-clipboard
    grim
    wf-recorder
    slurp
    gnome3.nautilus
    gnome3.gnome-terminal
    kate
    konsole
    dolphin
  ] ++ [
    kime
    gtk3_cache
  ];

  programs.home-manager = {
    enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}

