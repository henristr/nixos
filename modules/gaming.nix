{pkgs, ...}: {
  programs.prismlauncher = {
    enable = true;
  };

  programs.steam = {
    enable = true;
  };

  home.packages = with pkgs; [
    heroic
  ];
}
