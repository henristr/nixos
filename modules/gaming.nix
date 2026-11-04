{pkgs, ...}: {
  programs.prismlauncher = {
    enable = true;
  };

  home.packages = with pkgs; [
    heroic
  ];
}
