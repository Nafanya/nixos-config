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
      openclSupport = true;
    })
  ];

  services.llama-cpp = {
    enable = false;
    package = pkgs.llama-cpp.override {
      rocmSupport = true;
      openclSupport = true;
    };
    host = "0.0.0.0";
    port = 8080;
    openFirewall = true;
    model = "/mnt/data/downloads/Qwen_Qwen2.5-Coder-7B-Instruct-GGUF_qwen2.5-coder-7b-instruct-q8_0-00001-of-00003.gguf";
    extraFlags = [
      "--flash-attn"
      "--gpu-layers"
      "99"
      "--device"
      "ROCm0"
      "--jinja"
    ];
  };
}
