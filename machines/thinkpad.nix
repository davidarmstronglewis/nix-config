{ config, pkgs, ... }:

{

  home = {
    username      = "david";
    homeDirectory = "/home/david";
    packages      = import ../layers/development-packages.nix {};
    stateVersion  = "20.09";
  };

  # home.sessionVariables = {
  #   OPENSSL_LIB_DIR 
  # }

  programs = {
    home-manager.enable = true;
  
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
  
      # plugins = with pkgs.vimPlugins; [];
    };
  };

}
