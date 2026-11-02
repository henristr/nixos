{pkgs, ...}: let
  wallpapers = {
    nix = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/qz/wallhaven-qzyyxd.png";
      hash = "sha256-rmOjRVh14gYzdAJnp9pNYMrWDkfm7P/70JY3/8U4ndU=";
    };
    stefan = pkgs.fetchurl {
      url = "https://lehrerfolg.de/host-stefan-schmit.png";
      hash = "sha256-m0nCQvcol/9t3nAaw0th8mrjc3wdBUdmJOVOsp+RcEg=";
    };
  };
in {
  programs.plasma = {
    workspace.wallpaper = wallpapers.nix;

    hotkeys.commands = {
      "wallpaper-nix" = {
        name = "Wallpaper: Nix";
        key = "Meta+Alt+1";
        command = "plasma-apply-wallpaperimage ${wallpapers.nix}";
      };
      "wallpaper-stefan" = {
        name = "Wallpaper: Stefan";
        key = "Meta+Alt+2";
        command = "plasma-apply-wallpaperimage ${wallpapers.stefan}";
      };
    };
  };
}
