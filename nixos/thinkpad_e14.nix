{ pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    ./modules/defaults.nix

    ./modules/users/mike.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # fingerprint for my laptop
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-elan;
  services.upower.enable = true;
  security.pam.services.swaylock.fprintAuth = true;
  services.tlp.enable = true;

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  programs.ssh.startAgent = true;
  programs.steam = {
    enable = true;
    extraPackages = [ pkgs.gamescope pkgs.mangohud ];
    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
      };
    };
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  hardware.graphics = {
    extraPackages = with pkgs; [ mangohud gamemode ];
    extraPackages32 = with pkgs; [ mangohud gamemode ];
  };

  zramSwap = { enable = true; };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    fira-code
    nerdfonts
    font-awesome_5
    scientifica
  ];

  environment.systemPackages = with pkgs; [
    libgccjit
    nodePackages.typescript-language-server
    pulseaudio
    nss
    gcc
    nodejs_18

    (pkgs.writeShellScriptBin "set-mic-led" ''
      #!/bin/sh
      echo "$1" | tee /sys/class/leds/platform::micmute/brightness > /dev/null
    '')
    (pkgs.writeShellScriptBin "toggle-mic-mute" ''
      mute_status=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print ($2 == "yes") ? 0 : 1}')
      sudo set-mic-led "$mute_status"
      pactl set-source-mute @DEFAULT_SOURCE@ toggle
    '')
  ];

  security.sudo.extraRules = [{
    users = [ "mike" ];
    commands = [
      {
        command = "/run/current-system/sw/bin/toggle-mic-mute";
        options = [ "NOPASSWD" ];
      }
      {
        command = "/run/current-system/sw/bin/set-mic-led";
        options = [ "NOPASSWD" ];
      }
    ];
  }];

  programs.npm.enable = true;

  #Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.package =
    inputs.hyprland.packages."${pkgs.system}".hyprland;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
