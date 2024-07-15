{ inputs, pkgs, ... }:

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

    extraLuaConfig = ''
      ${builtins.readFile ../../dotfiles/neovim/barbar.lua}
      ${builtins.readFile ../../dotfiles/neovim/init.lua}
      ${builtins.readFile ../../dotfiles/neovim/lsp.lua}
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
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.neodev-nvim
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

      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];

    extraPackages = [ pkgs.wl-clipboard pkgs.nil pkgs.lua-language-server ];
  };
}
