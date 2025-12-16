let
  rick = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDP+CjPP2R8NSbGNPbHXJmkgY/e0XdvSyLxypKtDE2sF root@rick";
  hosts = [ rick ];
in
{
  "wg-rick.age".publicKeys = hosts;
}
