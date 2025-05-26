{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      lualine-nvim
      lazy-nvim
      nvim-tree-lua
      nvim-treesitter.withAllGrammars
      nvim-cmp
      conjure
      cmp-conjure
      cmp-nvim-lsp
      vim-vsnip
      luasnip
      mason-nvim
      nvim-lspconfig
      mason-lspconfig-nvim
      telescope-nvim
      gruvbox-baby
      vim-tmux-navigator
      vim-markdown
      gitsigns-nvim
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      neorg
      neorg-telescope
      parinfer-rust
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
