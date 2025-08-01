{pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession = {
      enable = true;
      args = [
        "--backend sdl"
        "--mangoapp"
      ];
    };
    package = pkgs.steam.override {
      extraPkgs = pkgs':
        with pkgs'; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib # Provides libstdc++.so.6
          libkrb5
          keyutils
          # Add other libraries as needed
        ];
    };
  };
}
