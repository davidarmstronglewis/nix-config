{ pkgs , ...  }:

{

  packages = with pkgs; [
    ktlint
    #maven
    #openjdk8
    #kotlin
  ];

}