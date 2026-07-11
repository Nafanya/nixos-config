{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    codex
    opencode
    claude-code
  ];
}
