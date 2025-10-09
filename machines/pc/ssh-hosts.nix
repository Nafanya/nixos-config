{
  #TODO: Setup ssh keys properly
  #home.file.".ssh/nikitoci.pub".source = "${flake-inputs.self}/keys/nikitoci.pub";

  home-manager.users.nikita = {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        #"*" = {
        #  identitiesOnly = true;
        #  identityFile = "~/.ssh/nikitoci.pub";
        #};
        "lynx" = {
          hostname = "192.168.1.250";
          user = "nikita";
          identityFile = "~/.ssh/lynx";
        };
        "lynx-root" = {
          hostname = "192.168.1.250";
          user = "root";
          identityFile = "~/.ssh/lynx";
        };
        "leopard" = {
          hostname = "leopard.local";
          user = "nikita";
          identityFile = "~/.ssh/id_pc_leopard";
        };
        "github.com" = {
          identityFile = "~/.ssh/pc-github";
        };
        "nihonzaru" = {
          hostname = "23.88.50.175";
          user = "root";
          identityFile = "~/.ssh/id_pc@hetzner_nikitoci.com";
        };
        "tamarin" = {
          hostname = "65.109.164.29";
          user = "root";
          identityFile = "~/.ssh/id_pc@hetzner_nikitoci.com";
        };
        "hexabytes" = {
          hostname = "194.104.94.47";
          user = "nikita";
          port = 19196;
          identityFile = "~/.ssh/id_pc@hexabytes.se";
        };
      };
    };
  };
}
