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
    imageName = "6cec5e39.img";

    extraFirmwareConfig = {
      start_x = 0;
      gpu_mem = 16;
      hdmi_group = 2;
      hdmi_mode = 8;
    };
  };

  networking = {
    hostName = "rpi4-cluster-node1";
    firewall.enable = false;
    firewall.allowedTCPPorts = [ 8888 22 ];
    #firewall.allowedUDPPorts = [ ... ];
    extraHosts = ''
10.0.83.10 9a7e6755 rpi4-cluster-head rpi4-cluster-head.giezenconsulting.com
'';
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    htop
    vim
    k3s
  ];
  
  services.k3s = {
    enable = true;
    token = "K10432a5b01d4e99869adcaebe756a9a4ad476fb4b7e951138e56cd536ca6b74389::server:mytoken";
    role = "agent";
    serverAddr="https://rpi4-cluster-head.giezenconsulting.com:6443";
    extraFlags = "--disable=servicelb";
    #disableAgent = "false";
  };

}
