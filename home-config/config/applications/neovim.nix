{ pkgs, ... }:
{
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      vim-lastplace
      vim-nix
    ];
  };
}
