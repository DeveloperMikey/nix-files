{pkgs, ...}: let
  #addons = pkgs.callPackage ./addons.nix {};
in {
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = fetchTarball {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/15ac3dfeaf828a9336e7e199123f8020cf04f440.tar.gz";
      sha256 = "sha256:03mlgnbyiwlr0xaip80iizi4brri0hgkvyplq82anjaimrr9pvfd";
    };
  };

  programs.firefox = {
    enable = true;
    profiles.mike = {
      name = "Mike";
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "svg.context-properties.content.enabled" = true;

        "browser.newtabpage.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.startup.page" = 3;
        "layout.css.prefers-color-scheme.content-override" = 0;
        #"extensions.autoDisableScopes" = 0;
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
        @import "firefox-gnome-theme/theme/colors/dark.css";

        ${builtins.readFile ./userChrome.css}
      '';
      userContent = ''
        @import "firefox-gnome-theme\/userContent.css";
      '';
      search = {
        force = true;
        default = "ddg";
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Nix Options" = {
            definedAliases = ["@no"];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
          "Home Manager Options" = {
            definedAliases = ["@hm"];
            urls = [
              {
                template = "https://home-manager-options.extranix.com";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
      /*
      # yank
      extensions = {
        force = true;
        packages = with addons; [
          ublock-origin
        ];
      };
      */
    };
  };

  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };
}
