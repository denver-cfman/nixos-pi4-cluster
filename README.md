# nixos-pi4-cluster

### check this flake
```
nix flake check --no-build github:denver-cfman/nixos-pi4-cluster?ref=main
```

### show this flake
```
nix flake show github:denver-cfman/nixos-pi4-cluster?ref=main
```

### build sd image for cluster head, use ` nix flake show github:denver-cfman/nixos-pi4-cluster?ref=main ` to list nodes
```
nix build -L github:denver-cfman/nixos-pi4-cluster?ref=main#nixosConfigurations._9a7e67.config.system.build.sdImage
```

### copy sd image
```
cp result/sd-images/9a7e67.img ~/
ls ~/
```

### remote update nix (nixos-rebuild) on cluster head
```
nix run github:serokell/deploy-rs github:denver-cfman/nixos-pi4-cluster?ref=main#_9a7e67 -- --ssh-user giezac --hostname 10.0.85.10
```
