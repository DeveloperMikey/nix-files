{...}: {
  networking.hostName = "MikesLaptop";
  security.polkit.enable = true;

  networking.networkmanager = {
    enable = true;
  };
}
