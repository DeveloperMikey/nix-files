{pkgs, ...}: let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  services.greetd = {
    enable = true;
    settings.default_session = {
      user = "greeter";
      command = "${tuigreet} --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
    };
  };
  /*
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
  */
}
