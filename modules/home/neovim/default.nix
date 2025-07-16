{
  pkgs,
  config,
  lib,
  ...
}:

let
  lazy-nix-helper-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lazy-nix-helper.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "b-src";
      repo = "lazy-nix-helper.nvim";
      rev = "22d0f4d737104cba6c18ba9ca3ff1db5160c67b5";
      hash = "sha256-4DyuBMp83vM344YabL2SklQCg6xD7xGF5CvQP2q+W7A=";
    };
  };

  sanitizePluginName =
    input:
    let
      name = lib.strings.getName input;
      vimplugin_removed = lib.strings.removePrefix "vimplugin-" name;
      luajit_removed = lib.strings.removePrefix "luajit2.1-" vimplugin_removed;
      lua5_1_removed = lib.strings.removePrefix "lua5.1-" luajit_removed;
      result = lib.strings.removeSuffix "-scm" lua5_1_removed;
    in
    result;

  pluginList =
    plugins:
    lib.strings.concatMapStrings (
      plugin: "  [\"${sanitizePluginName plugin.name}\"] = \"${plugin.outPath}\",\n"
    ) plugins;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      nixfmt-rfc-style # nixfmt
      nil # nix lsp
    ];

    plugins =
      with pkgs.vimPlugins;
      [
        lazy-nvim
        gruvbox-nvim

        nvim-lspconfig

        pkgs.vimPlugins.nvim-cmp
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.cmp-git
        pkgs.vimPlugins.cmp-cmdline
        pkgs.vimPlugins.cmp-buffer

        nvim-treesitter.withAllGrammars
      ]
      ++ [
        lazy-nix-helper-nvim
      ];

    extraLuaConfig = ''
      local plugins = {
        ${pluginList config.programs.neovim.plugins}
      }
      local lazy_nix_helper_path = "${lazy-nix-helper-nvim}"

      -- add the Lazy Nix Helper plugin to the vim runtime
      vim.opt.rtp:prepend(lazy_nix_helper_path)

      -- call the Lazy Nix Helper setup function
      local non_nix_lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      local lazy_nix_helper_opts = { lazypath = non_nix_lazypath, input_plugin_table = plugins }
      require("lazy-nix-helper").setup(lazy_nix_helper_opts)

      -- get the lazypath from Lazy Nix Helper
      local lazypath = require("lazy-nix-helper").lazypath()
      vim.opt.rtp:prepend(lazypath)

      require("init")
    '';
  };

  xdg.configFile."nvim/lua" = {
    source = ./nvim;
    recursive = true;
  };
}
