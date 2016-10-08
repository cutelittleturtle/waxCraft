# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports = [ ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";


  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6b98d168-41c8-4a97-9b7d-e2a60fccf4e0";
      fsType = "ext4";
    };

  swapDevices = [ ];

  nix.maxJobs = 2;
  virtualisation.virtualbox.guest.enable = true;
}
