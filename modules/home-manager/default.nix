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
        yta   = "yt-dlp --extract-audio -o '%(playlist_index)d-%(title)s.%(ext)s'";
        ytv   = "yt-dlp -o '%(playlist_index)d-%(title)s.%(ext)s'";
        ytv3  = "yt-dlp --write-auto-sub -f 'bestvideo[height<=360]+bestaudio/best[height<=360]' -o '%(playlist_index)d-%(title)s.%(ext)s'";
        ytv4  = "yt-dlp --write-auto-sub -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' -o '%(playlist_index)d-%(title)s.%(ext)s'";
        ytv7  = "yt-dlp --write-auto-sub -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' -o '%(playlist_index)d-%(title)s.%(ext)s'";
        ytv10 = "yt-dlp --write-auto-sub -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' -o '%(playlist_index)d-%(title)s.%(ext)s'";
        yts   = "mpv --ytdl-format='bestvideo[height<=360]+bestaudio'";
      };
      initExtra = ''
        # With host
        # export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
        # Without host
        export PS1='\[\e[92m\]\u\[\e[0m\]:\[\e[94m\]\W \[\e[0m\]\\$ '
      '';
    };

    alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
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

    tmux = {
      enable = true;

      mouse = false;
      keyMode = "vi";
      baseIndex = 1;

      # Neovim Stuff
      escapeTime = 10;
      terminal = "screen-256color";
      extraConfig = ''
        set-option -g focus-events on
        set-option -sa terminal-overrides ',xterm-256color:RGB'
      '';
    };

  };

}
