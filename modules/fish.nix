{config, ...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      fetch = "fastfetch";
      rebuild = "git -C /home/mike/.nixos add .; sudo nixos-rebuild switch --flake /home/mike/.nixos#${config.networking.hostName}";
    };
  };
}
