{pkgs, ...}: {
  hardware.sensor.iio.enable = true;

  services.libinput.enable = true;

  hardware.opentabletdriver.enable = true;

  environment.systemPackages = with pkgs; [
    maliit-keyboard
  ];
}

