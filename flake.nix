{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    zmk-config-nix.url = "github:Tomaszal/zmk-config-nix";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-darwin"];
      perSystem = {
        pkgs,
        self',
        system,
        ...
      }: {
        packages.default = pkgs.symlinkJoin {
          name = "firmware";
          paths = [
            self'.packages.lily58
            self'.packages.lotus58
          ];
        };
        packages.lotus58 = pkgs.linkFarm "lotus58" [
          {
            name = "lotus58-left.uf2";
            path = "${self'.packages.lotus58-left}/bin/zmk.uf2";
          }
          {
            name = "lotus58-right.uf2";
            path = "${self'.packages.lotus58-right}/bin/zmk.uf2";
          }
        ];
        packages.lotus58-left = inputs.zmk-config-nix.packages.${system}.zmkBinary {
          config = ./config;
          board = "nice_nano_v2";
          shield = "lotus58_left";
        };
        packages.lotus58-right = inputs.zmk-config-nix.packages.${system}.zmkBinary {
          config = ./config;
          board = "nice_nano_v2";
          shield = "lotus58_right";
        };
        packages.lily58 = pkgs.linkFarm "lily58" [
          {
            name = "lily58-left.uf2";
            path = "${self'.packages.lily58-left}/bin/zmk.uf2";
          }
          {
            name = "lily58-right.uf2";
            path = "${self'.packages.lily58-right}/bin/zmk.uf2";
          }
        ];
        packages.lily58-left = inputs.zmk-config-nix.packages.${system}.zmkBinary {
          config = ./config;
          board = "nice_nano_v2";
          shield = "lily58_left";
        };
        packages.lily58-right = inputs.zmk-config-nix.packages.${system}.zmkBinary {
          config = ./config;
          board = "nice_nano_v2";
          shield = "lily58_right";
        };
      };
    };
}
