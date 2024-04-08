{
  programs.kitty = {
    enable = true;
    theme = "Nord";
    shellIntegration = { enableZshIntegration = true; };
    extraConfig = ''
      macos_titlebar_color #2E3440
      window_padding_width 0
      window_margin_width 0
    '';
  };
}
