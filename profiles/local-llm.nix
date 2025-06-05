{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    (llama-cpp.override {
      rocmSupport = true;
      vulkanSupport = true;
      openclSupport = true;
    })
  ];

}
