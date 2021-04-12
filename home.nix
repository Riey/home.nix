{ config, pkgs, lib, ... }:

let
  emacs-overlay = (import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  }));
in
{
  nixpkgs.overlays = [ emacs-overlay ];
  imports = [
    ./direnv.nix
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
    nix-index
    nix-prefetch
    nload nodejs neofetch
    ripgrep lsd fd bat dua rust-analyzer
    cargo-feature cargo-deny cargo-edit cargo-outdated cargo-asm
    wine
    navi

    breeze-gtk
    breeze-icons
    breeze-qt5

    gh hub

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

