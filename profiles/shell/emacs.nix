{ pkgs, ... }:
{
  home-manager.users.nikita = {
    #TODO: move to "emacs.extraPacakges"
    home.packages = with pkgs; [
      nixfmt-rfc-style
      sqlite.dev
    ];

    programs.emacs = {
      enable = true;
    };

    services.emacs = {
      enable = true;
      client.enable = true;
      socketActivation.enable = true;
    };
  };
}
