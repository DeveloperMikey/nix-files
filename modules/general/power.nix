{
  pkgs,
  lib,
  ...
}: {
  services = {
    thermald.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;

    /*
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        START_CHARGE_THRESH_BAT0 = 60; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };
    */
    udev = {
      enable = true;
      extraRules = ''
        SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
        SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    powertop
  ];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
  '';

  systemd.services.battery-limit = {
    enable = true;
    serviceConfig = {
      Restart = "on-failure";
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "set-battery-limits" ''
        echo 80 >> /sys/class/power_supply/BAT0/charge_control_end_threshold
        echo 70 >> /sys/class/power_supply/BAT0/charge_control_start_threshold
      '';
    };
  };

  powerManagement.powertop.enable = true;
  powerManagement.enable = true;
}
