{ inputs, lib, config, pkgs, ... }: {

  home.packages = with pkgs; [ tmux ];

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -g default-shell ${pkgs.zsh}/bin/zsh
      set -g status-keys vi


      set-window-option -g mode-keys vi
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind-key x kill-pane

      set -g set-titles-string ' #{pane_title} '

      bind-key / copy-mode \; send-key ?

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
      set -g mouse on
    '';
    plugins = with pkgs.tmuxPlugins; [ yank ];
  };
}
