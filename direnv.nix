{ pkgs, ... }:
with pkgs;
{
  programs.direnv = {
    enable = true;
    stdlib = "";
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNixDirenvIntegration = true;
  };
}

