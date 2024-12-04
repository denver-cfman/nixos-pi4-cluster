# nixos-pi4-cluster
---
| ipv4 | MAC | SN | Note |
| --- | --- | --- | --- |
| 10.0.83.10 | dc:a6:32:62:18:5b | 9a7e6755 | RPi4 Cluster Head |
| 10.0.83.11 | dc:a6:32:63:be:5c | 6cec5e39 | RPi4 Cluster Node1 |
| 10.0.83.12 | dc:a6:32:59:1b:3c | b82078cf | RPi4 Cluster Node2 |
| 10.0.83.13 | dc:a6:32:22:89:63 | 4a5a17fd | RPi4 Cluster Node3 |
| 10.0.83.14 | dc:a6:32:1b:15:98 | 5d5b282a | RPi4 Cluster Node4 |
| 10.0.83.15 | dc:a6:32:61:eb:73 | 2c8663e7 | RPi4 Cluster Node5 |
| 10.0.83.16 | dc:a6:32:4b:88:93 | ccdb50d6 | RPi4 Cluster Node6 |
---
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
nix run github:serokell/deploy-rs github:denver-cfman/nixos-pi4-cluster?ref=main#_9a7e67 -- --ssh-user giezac --hostname 10.0.83.10
```
