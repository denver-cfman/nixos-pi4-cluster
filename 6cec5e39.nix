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
10.0.85.30 9a7e6755 rpi4-cluster-head rpi4-cluster-head.giezenconsulting.com
'';
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
    token = "K109225314c2362ddcf00d33e670e2cb09150ca11226f469c52c89d1b7ee4bd3a9c::server:mytoken";
    role = "agent";
    serverAddr="https://rpi4-cluster-head.giezenconsulting.com:6443";
    extraFlags = "--disable=servicelb";
    #disableAgent = "false";
  };

}
