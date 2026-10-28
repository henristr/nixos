{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;

    dedicatedServer.openFirewall = true;

    extest.enable = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
