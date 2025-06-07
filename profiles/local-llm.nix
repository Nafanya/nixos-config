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

  services.llama-cpp = {
    enable = false;
    package = pkgs.llama-cpp.override {
      rocmSupport = true;
      vulkanSupport = true;
      openclSupport = true;
    };
    host = "0.0.0.0";
    port = 8080;
    openFirewall = true;
    model = "/mnt/data/downloads/unsloth_Qwen3-30B-A3B-GGUF_Qwen3-30B-A3B-UD-IQ1_S.gguf";
    extraFlags = [
      "--flash-attn"
      "--gpu-layers"
      "99"
      "--device"
      "Vulkan0"
    ];
  };
}
