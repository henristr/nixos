{ config, lib, pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in

{
  imports =
    [
      inputs.home-manager.nixosModules.default
    ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";

    gfxmodeEfi = "1920x1080";

    theme = inputs.grub-themes.packages.${pkgs.system}.big-sur;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";

  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };

  services.desktopManager.plasma6.enable = true;
  
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };
  
  console.keyMap = "de-latin1-nodeadkeys";

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  users.users.henri = {
    isNormalUser = true;
    description = "Henri";
    extraGroups = [ "wheel" "networkmanager" ];
    # packages = with pkgs; [
    # ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "henri" = import ./home.nix;
    };
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    unstable.fetch
    git
    vim
    wget
  ];

  services.openssh.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };


  system.stateVersion = "26.05";

}

