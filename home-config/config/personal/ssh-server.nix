{ flake-inputs, lib, ... }:
{
  #TODO: Setup ssh keys properly
  #home.file.".ssh/nikitoci.pub".source = "${flake-inputs.self}/keys/nikitoci.pub";

  #programs.ssh.matchBlocks = {
  #  "*" = {
  #    identitiesOnly = true;
  #    identityFile = "~/.ssh/nikitoci.pub";
  #  };
  #};
}
