{lib, ...}: {
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
            family = "CommitMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "CommitMono Nerd Font";
          };
          italic = {
            family = "CommitMono Nerd Font";
          };
          size = 12;
        };
        shell.program = "tmux";
      };
    };

    tmux = {
      enable = true;

      mouse = false;
      keyMode = "vi";
      baseIndex = 1;

      # Neovim Stuff
      escapeTime = 10;
      terminal = "xterm-256color";
      extraConfig = ''
        set-option -g focus-events on
        set-option -sa terminal-overrides ',xterm-256color:RGB'
      '';
    };

    git = {
      enable = true;
      userName = "Mateja";
      userEmail = "mail@matejamaric.com";
      signing = {
        key = "8E2B38CBE4246E2B";
        signByDefault = true;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        url = {
          "git@git.ejobs.ro:" = {
            insteadOf = "https://git.ejobs.ro/";
          };
        };
        core = {
          ignorecase = false;
        };
        rerere = {
          enabled = true;
        };
      };
    };

  };

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["caps:swapescape"];
      sources = with lib.hm.gvariant; [
        (mkTuple ["xkb" "us"])
        (mkTuple ["xkb" "rs+latin"])
        (mkTuple ["xkb" "rs+alternatequotes"])
      ];
    };
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/mateja/Pictures/spencer-davis-iD5WcvlNWZg-unsplash.jpg";
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "Alacritty.desktop"
        "org.gnome.Nautilus.desktop"
        "gnucash.desktop"
        "thunderbird.desktop"
        "startcenter.desktop"
      ];
    };
    "org/gnome/shell/weather" = {
      automatic-location = true;
    };
    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-saver-profile-on-low-battery = false;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
  };

}
