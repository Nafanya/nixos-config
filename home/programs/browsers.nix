{ pkgs, config, ... }: {
  programs.firefox = {
    enable = true;
    #TODO: separate profiles for sensitive sites
    profiles.nikita = { };
  };
}
