{ config, lib, pkgs, ... }:

let

  shell = import ../layers/posix-shell.nix { inherit pkgs; };

in

{

  programs.bash = {
    enable       = true;
    shellAliases = shell.aliases;
    initExtra    = shell.initExtra;

    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyIgnore  = [ "ls" "cd" "exit" ];
  };

}
