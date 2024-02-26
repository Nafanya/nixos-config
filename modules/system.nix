{ config, pkgs, lib, ... }: {

  users.users.nikita = {
    isNormalUser = true;
    description = "nikitos";
    extraGroups = [ "wheel" "gamemode" ]; # TODO: cleanup gamemode?
    shell = pkgs.zsh; # TODO: remove from here and configure in hm?
  };

  users.users.natali = {
    isNormalUser = true;
    description = "natali";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      powerline-fonts
      powerline-symbols
      source-code-pro
      (nerdfonts.override {
        fonts =
          [ "SpaceMono" "JetBrainsMono" "DejaVuSansMono" "SourceCodePro" ];
      })
    ];
  };

  programs.dconf.enable = true;

  networking.firewall.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
    #TODO: move to home
    #xorg.xhost
    #(mplayer.override { v4lSupport = true; })
    #(ffmpeg.override {
    #  withUnfree = true;
    #  withNvenc = true;
    #  withNvdec = true;
    #})
  ];

  security.rtkit.enable = true;
  services = {
    dbus.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

}
