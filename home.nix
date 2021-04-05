{ config, pkgs, lib, ... }:

{
  imports = [
    ./emacs.nix
    ./sway.nix
    ./tool.nix
    ./neovim.nix
    ./zsh.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "riey";
  home.homeDirectory = "/home/riey";
  home.sessionVariables = {
    EDITOR = "nvim";
    # PAGER = "rp";
    PATH = "~/.local/bin:~/.cargo/bin:$PATH";
    LESSCHARSET = "utf-8";
  };

  home.packages = with pkgs; [
    nix-index
    htop nload nodejs neofetch
    ripgrep lsd fd bat

    gitAndTools.gh

    # torrent
    transmission-gtk

    # video
    mpv vlc ffmpeg rclone youtube-dl

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

