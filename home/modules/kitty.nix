{
  programs.kitty = {
    enable = true;
    theme = "Nord";
    shellIntegration = { enableZshIntegration = true; };
    settings = {
      font_family = "monospace";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "14.0";

      repaint_delay = "8";
      input_delay = "0";
      sync_to_monitor = "no";

      macos_titlebar_color = "#2E3440";
      window_padding_width = "0";
      window_margin_width = "0";
    };
  };
}
