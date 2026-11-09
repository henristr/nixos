{pkgs, ...}: {
  boot.loader.grub.splashImage = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/lm/wallhaven-lmq35p.jpg";
    sha256 = "0wab1icpnywfihf17zn3h6m3wmbrqrb066z9mk2328ia04q0giv3";
  };
}
