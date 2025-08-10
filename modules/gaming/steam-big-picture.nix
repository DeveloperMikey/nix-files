{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "steam-deck";
  nativeBuildInputs = [pkgs.makeWrapper];
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp ${pkgs.writeShellScript "steam-deck-script" ''
      set -xeuo pipefail
      exec gamescope -f -e --xwayland-count 2 --rt --mangoapp --adaptive-sync -- steam -pipewire-dmabuf -steamdeck -steamos3 > /dev/null 2>&1
    ''} $out/bin/steam-deck
    chmod +x $out/bin/steam-deck

    mkdir -p $out/share/wayland-sessions
    cat > $out/share/wayland-sessions/steam-deck.desktop << EOF
    [Desktop Entry]
    Name=Steam Deck
    Comment=Launch Steam inside Gamescope
    Exec=$out/bin/steam-deck
    Type=Application
    EOF
  '';
}
