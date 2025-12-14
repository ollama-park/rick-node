{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "rick";

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  programs.bash.shellInit = ''
    eval "$(keychain --eval --quiet ~/.ssh/rick)"
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG/6GNBs/+NewQ6AK4igl7dZp8+HgCUzl++eIBV/3TGk terow-rist@nixos''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILD7MLVPkz7GFurQGXAB9zPDUYWXbvM1LN7fA3Sv6e3g root@shtirlitz''
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    helix
    git
    keychain
  ];

  system.stateVersion = "25.05"; #change it!
}
