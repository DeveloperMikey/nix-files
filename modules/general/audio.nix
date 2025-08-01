{...}: {
  security.rtkit.enable = true; # realtime scheduler for pipewire, increased perf

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
