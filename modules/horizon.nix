{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.horizon-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
