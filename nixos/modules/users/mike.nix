{ inputs, ... }: {
  users.users.mike = {
    isNormalUser = true;
    description = "Michael";
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "mike" = import ../../../home-manager/mike.nix; };
  };
}
