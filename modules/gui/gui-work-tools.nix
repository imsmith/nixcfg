{config, pkgs, lib, ...}:

{


  # Base GUI applications that work on all platforms
  home.packages = with pkgs; [
    # Cross-platform GUI apps
    rclone
    #teams
    #slack
    
    # Python with Jupyter and data science packages
    (python3.withPackages (ps: with ps; [
      jupyter
      notebook
      pandas
      requests
      matplotlib
      ipython
    ]))
  ];

  # Fonts that work everywhere
  fonts.fontconfig.enable = lib.mkIf pkgs.stdenv.isLinux true;
}