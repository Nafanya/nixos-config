{
  config,
  pkgs,
  flake-inputs,
  ...
}:
{
  users = {
    users = {
      natali = {
        isNormalUser = true;
        description = "natali";
      };
    };
  };
}
