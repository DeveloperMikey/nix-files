# Requires redoing everything, not a good setup
{ inputs, pkgs, lib, ... }:
let
  tiny-code-action = pkgs.vimUtils.buildVimPlugin {
    name = "vim-easygrep";
    src = pkgs.fetchFromGitHub {
      owner = "rachartier";
      repo = "tiny-code-action.nvim";
      rev = "57d7f97924859a14b089146bd97b84058a500cfb";
      hash = "sha256-p1Q0j+cpOg/vDik2p/eO+6U2z58jJVFBUe40lHHjEac=";
    };
  };
in {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfig = ''
      colorscheme gruvbox
      nmap <space> <leader>
    '';

    plugins = [
      pkgs.vimPlugins.gruvbox-nvim
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.comment-nvim
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-git
      pkgs.vimPlugins.cmp-cmdline
      pkgs.vimPlugins.cmp-buffer
      pkgs.vimPlugins.neodev-nvim
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.nvim-colorizer-lua
      pkgs.vimPlugins.barbar-nvim
      pkgs.vimPlugins.nvim-cursorline
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.cmp_luasnip
      pkgs.vimPlugins.cheatsheet-nvim
      pkgs.vimPlugins.vim-be-good
      pkgs.vimPlugins.nvim-autopairs
      pkgs.vimPlugins.git-blame-nvim
      pkgs.vimPlugins.diffview-nvim
      pkgs.vimPlugins.conform-nvim
      pkgs.vimPlugins.oil-nvim
      pkgs.vimPlugins.neogit
      pkgs.vimPlugins.which-key-nvim
      pkgs.vimPlugins.nvim-dap
      pkgs.vimPlugins.alpha-nvim
      pkgs.vimPlugins.persisted-nvim
      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.dropbar-nvim
      pkgs.vimPlugins.telescope-symbols-nvim
      pkgs.vimPlugins.rustaceanvim
      tiny-code-action

      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];

    extraPackages = [
      pkgs.wl-clipboard
      pkgs.nil
      pkgs.lua-language-server
      pkgs.vscode-extensions.vadimcn.vscode-lldb
      pkgs.nixd
    ];
  };

  home.file."./.config/nvim/" = {
    source = ../../dotfiles/neovim;
    recursive = true;
  };

}
