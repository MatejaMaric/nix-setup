{pkgs, ...}: {
  home.stateVersion = "23.05";
  home.packages = [];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
