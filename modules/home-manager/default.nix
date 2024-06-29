{pkgs, ...}: {
  home.stateVersion = "23.11";
  home.packages = [];
  home.sessionVariables = {
    EDITOR = "nvim";
  };


  programs = {

    bash = {
      enable = true;
      shellAliases = {
        yta   = "yt-dlp --extract-audio -o '%(playlist_index)d-%(title)s.%(ext)s'"
        ytv   = "yt-dlp -o '%(playlist_index)d-%(title)s.%(ext)s'"
        ytv3  = "yt-dlp --write-auto-sub -f 'bestvideo[height<=360]+bestaudio/best[height<=360]' -o '%(playlist_index)d-%(title)s.%(ext)s'"
        ytv4  = "yt-dlp --write-auto-sub -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' -o '%(playlist_index)d-%(title)s.%(ext)s'"
        ytv7  = "yt-dlp --write-auto-sub -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' -o '%(playlist_index)d-%(title)s.%(ext)s'"
        ytv10 = "yt-dlp --write-auto-sub -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' -o '%(playlist_index)d-%(title)s.%(ext)s'"
        yts   = "mpv --ytdl-format='bestvideo[height<=360]+bestaudio'"
      };
    };

    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "DroidSansM Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "DroidSansM Nerd Font";
          };
          italic = {
            family = "DroidSansM Nerd Font";
          };
          size = 12;
        };
      };
    };

  };

}
