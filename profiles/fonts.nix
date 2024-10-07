{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      powerline-fonts
      powerline-symbols
      source-code-pro
      (nerdfonts.override {
        fonts = [
          "SpaceMono"
          "JetBrainsMono"
          "DejaVuSansMono"
          "SourceCodePro"
        ];
      })
    ];
  };
}
