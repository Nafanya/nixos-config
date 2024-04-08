{ pkgs, ... }: {
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
  };
}
