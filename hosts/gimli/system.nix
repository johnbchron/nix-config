{ pkgs, ... }: {
  imports = [
    ./generated.nix
  ];

  # bootloader
  boot = {
    binfmt.emulatedSystems = [ "x86_64-linux" "i686-linux" ];
    kernelParams = [
      "apple_dcp.show_notch=1"
    ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    m1n1CustomLogo = ../../media/hexaradialis.png;
  };

  # asahi
  hardware.asahi = {
    # withRust = true;
    # useExperimentalGPUDriver = true;
    # experimentalGPUInstallMode = "replace";
    setupAsahiSound = true;
    # extractPeripheralFirmware = false;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "gimli";
    firewall.allowedTCPPorts = [
      # for viewing local development from mobile
      3000
      # minecraft local lan
      50000
    ];
    # nameservers = [
    #   # # google
    #   # "2001:4860:4860::8888"
    #   # "2001:4860:4860::8844"
    #   # cloudflare
    #   "2606:4700:4700::1111"
    #   "2606:4700:4700::1001"
    # ];

  };

  environment.systemPackages = with pkgs; [
    # for iphone mounting
    ifuse
    libimobiledevice
  ];
}
