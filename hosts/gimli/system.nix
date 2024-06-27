{ pkgs, ... }: {
  imports = [
    ./generated.nix
  ];

  # bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    binfmt.emulatedSystems = [ "x86_64-linux" "i686-linux" ];
    kernelParams = [ "apple_dcp.show_notch=1" ];
    m1n1CustomLogo = ../../media/hexaradialis.png;
  };

  # asahi
  hardware.asahi = {
    withRust = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    setupAsahiSound = true;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "gimli";
  };

  environment.systemPackages = with pkgs; [
    # for iphone mounting
    ifuse
    libimobiledevice
  ];

  environment.variables = {
    # bc gl is weird on this machine
    "GLOBAL_LIBGL" = "${pkgs.lib.makeLibraryPath [ pkgs.libGL ]}";
  };
}
