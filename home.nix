{ config, pkgs, ... }:

{
  home.username = "nikita";
  home.homeDirectory = "/home/nikita";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Nikita Iashchenko";
    userEmail = "nikita.yaschenko@gmail.com";
  };

  programs.neovim = {
    defaultEditor = true;
    enable = true;
  };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    nnn # terminal file manager

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    bat # A cat(1) clone with syntax highlighting and Git integration

    # networking tools
    aria2 # A lightweight multi-protocol & multi-source command-line download utility

    # misc
    file
    which
    tree

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    #nix-output-monitor

    btop  # replacement of htop/nmon
    iotop # io monitoring

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    rofi # app launcher for hyprland
  ];

  # kitty -- a cross-platform, GPU-accelerated terminal emulator
  programs.kitty = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your cusotm bashrc here
    #bashrcExtra = ''
    #  export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    #'';

    # set some aliases, feel free to add more or remove some
    #shellAliases = {
    #  urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    #  urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    #};
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
