{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
  };

  programs.mako = {
    enable = true;
    # 5 secs
    defaultTimeout = 5000;
  };

  programs.bat = {
    enable = true;
    config.italic-text = "always";
  };

  programs.lsd = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Riey";
    userEmail = "creeper844@gmail.com";
    signing = {
      key = "6D3331CEE6D14FDAFC2B39872D09658FE7407060";
      signByDefault = true;
      gpgPath = "${pkgs.gnupg}/bin/gpg2";
    };
    extraConfig = {
      github.user  = "Riey";
      color.ui = "always";
      "credential \"https://github.com\"".helper = "!gh auth git-credential";
    };
  };

  programs.gpg = {
    enable = true;
  };

  # rclone
  xdg.configFile."rclone/rclone.conf".source = ./rclone.conf;
  home.file.".local/bin/encode_2pass.sh".source = ./local-bin/encode_2pass.sh;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "6D3331CEE6D14FDAFC2B39872D09658FE7407060" ];
    pinentryFlavor = "gnome3";
  };
}

