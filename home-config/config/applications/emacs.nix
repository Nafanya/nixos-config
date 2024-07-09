{ pkgs, flake-inputs, ... }:
{
  home.packages = with pkgs; [
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        ru
      ]
    ))

    nixfmt-rfc-style

    # markdown
    pandoc

    libnotify
    sqlite.dev
  ];

  programs.emacs = {
    enable = true;
  };

  services.emacs = {
    enable = true;
    client = {
      enable = true;
      arguments = [
        "--no-wait"
        "--create-frame"
      ];
    };
    socketActivation.enable = true;
  };
}
