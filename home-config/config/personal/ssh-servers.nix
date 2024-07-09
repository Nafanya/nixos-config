{ flake-inputs, lib, ... }:
{
  #TODO: Setup ssh keys properly
  #home.file.".ssh/nikitoci.pub".source = "${flake-inputs.self}/keys/nikitoci.pub";

  programs.ssh.matchBlocks = {
    #"*" = {
    #  identitiesOnly = true;
    #  identityFile = "~/.ssh/nikitoci.pub";
    #};
    "lynx" = {
      hostname = "lynx.local";
      user = "nikita";
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
      hostname = "167.235.29.144";
      user = "root";
      identityFile = "~/.ssh/id_pc@hetzner_nikitoci.com";
    };
  };
}
