{
  home,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      fetch = "fastfetch";
      rebuild = "git -C /home/mike/.nixos add .; sudo nixos-rebuild switch --flake /home/mike/.nixos#${config.networking.hostName}";
      backupFirefox = "cp ~/.mozilla/firefox/mike/prefs.js ~/.mozilla/firefox/mike/prefs.js.bak";
      diffFirefox = "nvim -d ~/.mozilla/firefox/mike/prefs.js.bak ~/.mozilla/firefox/mike/prefs.js";
    };
    interactiveShellInit = ''
      set fish_greeting

      zoxide init fish | source
      direnv hook fish | source

      if type -q eza
        alias ls='eza'
      end

      function fish_prompt --description 'Write out the prompt'
          if test -n "$IN_NIX_SHELL"
            set dev_env ""
          else
            set dev_env ""
          end

          set -l last_pipestatus $pipestatus
          set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
          set -l normal (set_color normal)
          set -q fish_color_status
          or set -g fish_color_status red

          # Color the prompt differently when we're root
          set -l color_cwd $fish_color_cwd
          set -l suffix '>'
          if functions -q fish_is_root_user; and fish_is_root_user
              if set -q fish_color_cwd_root
                  set color_cwd $fish_color_cwd_root
              end
              set suffix '#'
          end

          # Write pipestatus
          # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
          set -l bold_flag --bold
          set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
          if test $__fish_prompt_status_generation = $status_generation
              set bold_flag
          end
          set __fish_prompt_status_generation $status_generation
          set -l status_color (set_color $fish_color_status)
          set -l statusb_color (set_color $bold_flag $fish_color_status)
          set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

          echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $dev_env $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
      end


      function nix
        if test (count $argv) -gt 0 -a "$argv[1]" = "develop"
          set argv $argv[2..-1]
          command nix develop -c $SHELL $argv
        else
          command nix $argv
        end
      end

      function devshell
        nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$argv[1]"
      end
    '';
  };

  programs.direnv = {
    enable = true;
    silent = true;
    enableFishIntegration = true;
  };
}
