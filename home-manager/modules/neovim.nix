# Requires redoing everything, not a good setup
{ inputs, pkgs, lib, ... }:
{

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
      pkgs.vimPlugins.rustaceanvim
      pkgs.vimPlugins.nvim-dap
      pkgs.vimPlugins.alpha-nvim
      pkgs.vimPlugins.persisted-nvim
      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.dropbar-nvim
      pkgs.vimPlugins.telescope-symbols-nvim

      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];

    extraPackages = [
      pkgs.wl-clipboard
      pkgs.nil
      pkgs.lua-language-server
      pkgs.rustfmt
      pkgs.rust-analyzer
      pkgs.vscode-extensions.vadimcn.vscode-lldb
    ];
  };

  home.file."./.config/nvim/" = {
    source = ../../dotfiles/neovim;
    recursive = true;
  };

}
