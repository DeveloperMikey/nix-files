{ inputs, ... }: {
  users.users.mike = {
    isNormalUser = true;
    description = "Michael";
    extraGroups = [ "networkmanager" "wheel"];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "mike" = import ../../../home-manager/mike.nix;
    };
  };
}
