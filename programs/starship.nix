{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable                = true;
    enableBashIntegration = true;

    settings = {
      add_newline       = true;
      scan_timeout      = 30;
      character.symbol  = "➜";
      git_branch.symbol = "";
    };
  };
}
