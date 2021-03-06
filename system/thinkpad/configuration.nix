# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

let
  CloudflareDNS = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];

in

{ config, pkgs, ... }:
{

  nix.allowedUsers = [ "@wheel" ];
  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  hardware.opengl.driSupport32Bit = true;

  xdg.portal.enable = true;

  imports = [
    ./hardware-configuration.nix
    <nixos-hardware/lenovo/thinkpad/t490>
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    nameservers = CloudflareDNS;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      insertNameservers = CloudflareDNS;
      dns = "systemd-resolved";
    };

    hostName = "armstronglewis";
    useDHCP = false;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };


  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "US/Pacific";

  environment = {
    pantheon.excludePackages = (with pkgs; [
      gnome3.epiphany
      gnome3.gnome-font-viewer
      gnome3.geary
    ]);

    shells = with pkgs; [
      zsh nushell
    ];

    systemPackages = with pkgs; [
      firefox
      spotify

      # IDEs
      jetbrains.idea-ultimate

      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.Nix
          llvm-org.lldb-vscode
          matklad.rust-analyzer
          ms-python.python
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vim";
            publisher = "vscodevim";
            version = "1.18.5";
            sha256 = "0cbmmhkbr4f1afk443sgdihp2q5zkzchbr2yhp7bm5qnv7xdv5l4";
          }
          {
            name = "gruvbox-material";
            publisher = "sainnhe";
            version = "6.3.4";
            sha256 = "0dwizyp5rph9z2sfcl2l7dwnmii7976vhrwahzsbsc8smvix1k5f";
          }
          {
            name = "lucy-vscode";
            publisher = "juliettepretot";
            version = "2.8.2";
            sha256 = "0r4d3cbagxzvwhqa5d2mri4i3wipnba9h9yicml6ik1qwb26p2qz";
          }

          {
            name = "monochrome";
            publisher = "anotherglitchinthematrix";
            version = "2.3.0";
            sha256 = "114q6n51kb60xh1jh9yj5wh1d3a5bw7j4v34mismbr86smsd77z6";
          }
          {
            name = "markdown-all-in-one";
            publisher = "yzhang";
            version = "3.4.0";
            sha256 = "0ihfrsg2sc8d441a2lkc453zbw1jcpadmmkbkaf42x9b9cipd5qb";
          }
          {
            name = "kotlin";
            publisher = "fwcd";
            version = "0.2.20";
            sha256 = "1psq1p5pwqspxwm7zgshisqrmc9f7y04p6ic3idlm90q6w0j7qd0";
          }
          {
            name = "go";
            publisher = "golang";
            version = "0.21.1";
            sha256 = "1914kicadrqp653mcd4h26n7g4fzlzw55r36ws3r0lf8rzcb8sva";
          }
          {
            name = "terraform";
            publisher = "hashicorp";
            version = "2.5.0";
            sha256 = "12qc63kvx0hsxfci86x9gzcsqckcsridpcsy4nm6b8s7g6aq8jx8";
          }
        ];
      })

      # Shells
      zsh nushell

      # Tools
      file
      lsof
      killall
      bind

      # Document viewing
      bookworm
      aesop

      # Note taking
      libreoffice
      obsidian
      pantheon.notes-up
      neuron-notes

      ## Desktop Applications

      elementary-planner
      ideogram
      font-manager
      monitor
      pantheon.elementary-wallpapers
      torrential

      # Developer System Packages
      docker docker-compose
      sequeler
      hashit
      insomnia
      staruml

      slack
      zoom-us
      teams
      discord

      _1password-gui

      transmission-gtk

      clamav

      # Remote Desktop
      x11vnc
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #sound.enable = true;
  #hardware.pulseaudio.enable = true;

  # Enable Avahi
  #services.avahi.enable = true;

  services = {
    fwupd.enable = true;
    flatpak.enable = true;
    pantheon.contractor.enable = true;

    xserver = {
      enable = true;
      layout = "us";

      displayManager.lightdm.enable = true;
      desktopManager.pantheon = {
        enable = true;
        extraGSettingsOverrides = ''
          [org.gnome.desktop.default-application.terminal]
          exec='alacritty'
        '';
      };

      # Enable touchpad support.
      libinput.enable = true;

      resolutions = [
        { x = 1920; y = 1080; }
        { x = 1792; y = 1008; }
        { x = 1664; y = 936;  }
        { x = 1600; y = 900;  }
      ];
    };

    resolved = {
      enable = true;
    };

    avahi = {
      enable          = true;
      nssmdns         = true;
      ipv4            = true;
      ipv6            = true;
      domainName      = "alocal";

      publish = {
        enable = true;
        addresses = true;
      };
    };
  };

  virtualisation.docker.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    fira-mono
  ];

  users.users.david = {
    isNormalUser = true;
    home = "/home/david";
    description = "David Armstrong Lewis";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
