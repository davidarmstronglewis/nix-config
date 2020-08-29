{ pkgs
, config
, lib
, theme
, extraGitIgnores ? []
, ...
}:

with pkgs;

{
  # Program Definition
  # - https://github.com/rycee/home-manager/blob/master/modules/programs/git.nix
  home.programs.git = {
    enable       = true;
    package      = gitAndTools.gitFull;

    delta = {
      enable = true;
      options = {
        syntax-theme = theme.bat.theme;
      };
    };

    userName  = "David Armstrong Lewis";
    userEmail = "david@armstronglewis.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
    };

    ignores = extraGitIgnores;

    includes = [
      {
        path = ./deep6.git;
        condition = "gitdir:~/Developer/Deep 6 AI/";
      }
    ];

    aliases = {
      lg1-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";

      lg2-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";

      lg3-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";

      lg1 = "lg1-specific --all";
      lg2 = "lg2-specific --all";
      lg3 = "lg3-specific --all";
      lg  = "lg1";
    };
  };

  packages = [
    gitAndTools.gh
    gitAndTools.delta
    gitAndTools.gitui
  ];
}
