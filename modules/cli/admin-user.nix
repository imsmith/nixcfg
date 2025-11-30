users.users.admin = {
    name = "Administrator User";
    description = "Admin user with full privileges";
    isNormalUser = true;
    extraGroups = [ "admin" "wheel" ];
    shell = "/bin/bash";
    uid = 1;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGEnFnPz+ibD5TYf5ahL/UM7062pQ2FFqtcGYpWOY1KO imsmith@radon"
    ];
}