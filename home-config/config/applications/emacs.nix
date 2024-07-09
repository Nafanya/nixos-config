{ pkgs, flake-inputs, ... }:
let
  inherit (flake-inputs) self;
  inherit (flake-inputs.self.packages.${pkgs.system}) emacs;
  inherit (flake-inputs.nixd.packages.${pkgs.system}) nixd;
in
{
  home.packages =
    (with pkgs; [
      (aspellWithDicts (
        dicts: with dicts; [
          en
          en-computers
          ru
          ua
        ]
      ))

      nixfmt-rfc-style

      # markdown
      pandoc

      libnotify
      sqlite.dev
    ])
    ++ [ nixd ];

  programs.emacs = {
    enable = true;
    package = emacs;
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
