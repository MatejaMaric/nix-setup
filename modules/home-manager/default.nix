{pkgs, ...}: {
  home.stateVersion = "23.11";
  home.packages = [];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
