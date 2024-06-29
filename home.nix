{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "churst";
  home.homeDirectory = "/home/churst";


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  #dotfiles
  home.file = {
    ".config/hypr/hyprland.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/churst/.config/home-manager/hypr/hyprland.conf";
    };
    ".config/hypr/hyprpaper.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/churst/.config/home-manager/hypr/hyprpaper.conf";
    };
    ".config/waybar/power.sh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/churst/.config/home-manager/power.sh";
    };
    ".config/hypr/start.sh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/churst/.config/home-manager/hypr/start.sh";
    };
    ".config/hypr/audio.sh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/churst/.config/home-manager/hypr/audio.sh";
    };
    "wallpapers/wallpaper.jpg" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/churst/.config/home-manager/hypr/wallpaper.jpg";
    };
    ".config/rofi/config.rasi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/churst/.config/home-manager/rofi/config.rasi";
    };
  };


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
     (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
     pkgs.balena-cli
     pkgs.wineWowPackages.waylandFull
     pkgs.lutris
     pkgs.kakoune
     pkgs.spotify
     pkgs.google-chrome
     pkgs.appimage-run
     pkgs.p7zip
     pkgs.discord
     pkgs.zellij
     pkgs.odin
     pkgs.ols
     pkgs.rustup
     pkgs.nodejs_20
     pkgs.zlib
     pkgs.nodePackages.svelte-language-server
     pkgs.python3
     pkgs.rare
     pkgs.heroic
     pkgs.opam
     pkgs.gnumake42
     pkgs.neovide
     pkgs.ldtk
     pkgs.mold
     pkgs.clang

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "edit-home" ''
      nvim ~/.config/home-manager/home.nix
      home-manager switch
    '')
    (pkgs.writeShellScriptBin "edit-system" ''
      sudo nvim ~/system/nixos/configuration.nix
      sudo nixos-rebuild switch --flake ~/system
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  programs.bash.initExtra = "test -r /home/churst/.opam/opam-init/init.sh && . /home/churst/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true";
  
  
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";
      modules-left = [ "custom/power" "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "custom/pipewire" "pulseaudio" "battery" "tray"];
      "hyprland/workspaces" = {
        "on-click" = "activate";
        "all-outputs" = true;
      };
      "custom/pipewire" = {
        exec = "pw-volume status";
        "return-type" = "json";
        interval = "once";
        signal = 8;
        format = "{icon} {percentage}";
        "format-icons" = {
          mute = "x";
          default = ["---" "--" "-"];
        };
      };
      "custom/power" = {
        "on-click" = "bash ~/.config/waybar/power.sh";
        format = "";
      };
      clock = {
        format = "  {:%a %b %d  %I:%M %p}";
        tooltip = true;
      };
      battery = {
        format = "{capacity}%  ";
      };
    }];

    style = ''
      @define-color bg rgba(4, 20, 45, 0.50);
      @define-color bg-alt #252428;
      @define-color fg #f5f5f5;
      @define-color alert #f53c3c;
      @define-color disabled #a5a5a5;
      @define-color bordercolor #29c8e5;
      @define-color highlight #FBD47F;
      @define-color activegreen #8fb666;
      
      * {
        min-height: 0;
        font-family: "JetBrainsMono Nerd Font", "Hack Nerd Font", FontAwesome, Roboto,
          Helvetica, Arial, sans-serif;
        font-size: 14px;
        /* background-color: #04142d; */
      }
      
      window#waybar {
        color: #f5f5f5;
        background: @bg00;
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      
      window#waybar.empty {
        opacity: 0.3;
      }
      
      .modules-left {
        background: @bg;
        border: 2px solid @bordercolor;
        border-radius: 20px;
      
        padding-right: 5px;
        padding-left: 5px;
      }
      
      .modules-right {
        background: @bg;
        border: 2px solid @bordercolor;
        border-radius: 20px;
      
        padding-right: 5px;
        padding-left: 5px;
      }
      
      .modules-center {
        background: @bg;
        border: 2px solid @bordercolor;
        border-radius: 20px;
      
        padding-right: 5px;
        padding-left: 5px;
      }
      
      button {
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        /* Avoid rounded borders under each button name */
        border: none;
        border-radius: 0;
      }
      
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px transparent;
      }
      
      #workspaces button {
        /* background-color: #252428; */
        color: @fg;
      }
      
      #workspaces button.urgent {
        color: @alert;
        /* background-color: #252428; */
        /* border: 3px solid #f53c3c; */
      }
      #workspaces button.empty {
        color: @disabled;
        /* background-color: #252428; */
      }
      
      #workspaces button.active {
        color: @activegreen;
        /* background-color: #252428; */
        /* border: 3px solid #7bcbd5; */
      }
      
      #workspaces button.focused {
        background-color: @fg;
        color: @bg-alt;
      }
      
      /* Uncomment If using icons instead of number for workspaces*/
      
      /* #workspaces, */
      /* #workspaces button,  */
      /* #workspaces button.active, */
      /* #workspaces button:hover,  */
      /* #workspaces button.focused, */
      /* #workspaces button.urgent { */
      /*     padding-right: 0px;  */
      /*     padding: 0px 6px;  */
      /*     padding-left: 3px; */
      /*     color: #F5F5F5; */
      /*     background-color: rgba(0, 0, 0, 0); */
      /* }  */
      
      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #pulseaudio.muted,
      #wireplumber,
      #custom-media,
      #taskbar,
      #tray,
      #tray menu,
      #tray > .needs-attention,
      #tray > .passive,
      #tray > .active,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #custom-power,
      #mpd {
        padding: 0px 5px;
        padding-right: 10px;
        margin: 3px 3px;
        color: @fg;
        background: none;
        /* background-color: #252428; */
      }
      
      #custom-power {
        color: #f53c3c;
      }
      
      #cpu {
        color: #cb221b;
      }
      
      #temperature {
        color: #d55c0d;
      }
      
      #memory {
        color: #d69821;
      }
      
      #disk {
        color: #979618;
      }
      
      #backlight {
        color: #679c68;
      }
      
      #pulseaudio {
        color: #448486;
      }
      
      #clock {
        color: #b16186;
      }
      
      #battery {
        color: #48aa4c;
      }
      
      #network {
        color: #5cc084;
      }
      
      label:focus {
        background-color: #000000;
      }
      
      #network.disconnected {
        background-color: @alert;
      }
      
      #battery.charging,
      #battery.plugged {
        color: #f5f5f5;
        background-color: #26a65b;
      }
      
      #wireplumber.muted {
        background-color: @alert;
      }
      
      #language {
        background: @fg;
        color: @bg-alt;
        padding: 0 5px;
        margin: 0 5px;
        min-width: 16px;
      }
      
      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }
      
      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }
      @keyframes blink {
        to {
          background-color: @fg;
          color: @bg-alt;
        }
      }
      
      #battery.critical:not(.charging) {
        background-color: @alert;
        color: @fg;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
    ''; 
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/churst/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
