{ pkgs
, ...
}:

let

  emacs =
    if pkgs.stdenv.isDarwin
    then pkgs.emacsMacport
    else pkgs.emacs;

in {

  programs.emacs = {
    enable = true;
    package = emacs;

    extraPackages =
      epkgs: [
        # epkgs.evil
        # epkgs.doom
        # epkgs.magit
      ];
  };

}
