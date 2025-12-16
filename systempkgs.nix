{ pkgs, ... } :
{
    environment.systemPackages = with pkgs; [
    helix
    git
    keychain
    wireguard-tools
    ];
}
