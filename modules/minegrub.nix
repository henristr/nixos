{config, ...}: {
  boot.loader.grub.minegrub-world-sel = {
    enable = true;
    background = "assets/background-scaled/background-2560x1440.png";
    customIcons = with config.system.nixos; [
      {
        name = distroId;
        lineTop = distroName + " " + codeName + " (" + version + ")";
        lineBottom = "Survival Mode, No Cheats, Version: " + release;
        imgName = "nixos";
      }
    ];
  };
}
