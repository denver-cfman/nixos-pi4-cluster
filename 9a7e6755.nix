{
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    ./sd-image.nix
    ./common.nix
  ];

  sdImage = {
    compressImage = false;
    imageName = "9a7e6755.img";

    extraFirmwareConfig = {
      start_x = 0;
      gpu_mem = 16;
      hdmi_group = 2;
      hdmi_mode = 8;
    };
  };

  networking = {
    hostName = "9a7e6755";
    hosts = {
      "127.0.0.1" = [ "9a7e6755.local" ];
      "10.0.83.10" = [ "9a7e6755.local" ];
    };
    firewall.enable = false;
    firewall.allowedTCPPorts = [ 6443 22 ];
    #firewall.allowedUDPPorts = [ ... ];
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    htop
    vim
    k3s_1_26
  ];

  services.k3s = {
    enable = true;
    extraFlags = "--disable=servicelb --tls-san=rpi4-cluster-head.giezenconsulting.com --advertise-address=10.0.83.10 --bind-address=10.0.83.10 --write-kubeconfig-mode=644";
    role = "server";
    token = "mytoken";
    #disableAgent = "false";
  };

}
