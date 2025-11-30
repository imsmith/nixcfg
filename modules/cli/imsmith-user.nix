users.users.imsmith = {
    name = "Ian Smith";
    description = "Ian Smith user with limited privileges";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGEnFnPz+ibD5TYf5ahL/UM7062pQ2FFqtcGYpWOY1KO imsmith@radon"
    ];
}