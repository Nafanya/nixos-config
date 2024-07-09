{ flake-inputs, pkgs, ... }:
{
  imports = [ ./ssh-servers.nix ];

  home.packages = with pkgs; [ mpv ];

  programs.git = {
    enable = true;
    userName = "Nikita Iashchenko";
    userEmail = "nikita.yaschenko@gmail.com";
    diff-so-fancy = {
      enable = true;
      pagerOpts = [
        "--tabs=4"
        "-R"
      ];
    };
    extraConfig = {
      github.user = "nafanya";
    };
  };
}
