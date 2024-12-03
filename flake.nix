{
  description = "Flake for building a Raspberry Pi Zero 2 SD image";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    deploy-rs,
    nixos-hardware
  }@inputs:
    let
      # see https://github.com/NixOS/nixpkgs/issues/154163
      overlays = [
        (final: super: {
          makeModulesClosure = x:
            super.makeModulesClosure (x // { allowMissing = true; });
        })
      ];
      specialArgs = {
        inherit nixos-hardware inputs;
      };
    in rec {
      #10.0.85.30	dc:a6:32:62:18:5b	9a7e6755	RPi4 Cluster Head
      #10.0.85.31	dc:a6:32:63:be:5c	6cec5e39	RPi4 Cluster Node1
      #10.0.85.32	dc:a6:32:59:1b:3c	b82078cf	RPi4 Cluster Node2
      #10.0.85.33	dc:a6:32:22:89:63	4a5a17fd	RPi4 Cluster Node3
      #10.0.85.34	dc:a6:32:1b:15:98	5d5b282a	RPi4 Cluster Node4
      #10.0.85.35	dc:a6:32:61:eb:73	2c8663e7	RPi4 Cluster Node5
      #10.0.85.36	dc:a6:32:4b:88:93 ccdb50d6	RPi4 Cluster Node6
      nixosConfigurations = {
         _9a7e6755 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./9a7e6755.nix
          ];
        };
         _6cec5e39 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./6cec5e39.nix
          ];
        };
        b82078cf = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./b82078cf.nix
          ];
        };
        _4a5a17fd = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./4a5a17fd.nix
          ];
        };
        _5d5b282a = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./5d5b282a.nix
          ];
        };
        _2c8663e7 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./2c8663e7.nix
          ];
        };
        ccdb50d6 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./ccdb50d6.nix
          ];
        };
      };
          
      deploy = {
        user = "root";
        sshOpts = [ "-i" "/home/giezac/.ssh/pzw2.rsa" ];
        nodes = {
          _9a7e6755 = {
            hostname = "9a7e6755";
            profiles.system.path =
              deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations._9a7e6755;
            #remoteBuild = true;
            
          };
        };
      };
    };
}
