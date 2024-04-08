# MacOS

## Installation

1. I used [determinate systems installer](https://determinate.systems/posts/determinate-nix-installer/) to install nix on MacOS. Worked pretty well.

2. For some reason, no `nixpkgs` channel was added. Fixed it by:

```
$ nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
```


