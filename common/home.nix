{
  config,
  pkgs,
  hostname,
  inputs,
  ...
}: let
  flakePath = "${homeDir}/nixos-dotfiles";

  homeDir = config.home.homeDirectory;

  hostModules = {
    vm = [];
    smtpad = [../modules/gaming.nix ../modules/jetbrains.nix];
  };

  username = config.home.username;

  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/qz/wallhaven-qzyyxd.png";
    hash = "sha256-rmOjRVh14gYzdAJnp9pNYMrWDkfm7P/70JY3/8U4ndU=";
  };
in {
  imports =
    [
    ]
    ++ (hostModules.${hostname} or []);

  home.username = "henri";
  home.homeDirectory = "/home/henri";

  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    alejandra
    bitwarden-cli
    bitwarden-desktop
    fzf
    go
    nixd
    nodejs
    tree
    vscode
  ];

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/home/henri/.bitwarden-ssh-agent.sock";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "nh os switch";
      lo = "qdbus org.kde.Shutdown /Shutdown logout";
    };
  };

  programs.firefox = {
    enable = true;
    profiles.henri = {
      isDefault = true;
      search = {
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["nix"];
          };
        };
      };

      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        bitwarden
      ];
    };
  };

  programs.fzf.enableBashIntegration = true;

  programs.git = {
    enable = true;
    settings.user = {
      name = "henristr";
      email = "strickerhenri@gmail.com";
    };
  };

  programs.plasma = {
    enable = true;

    hotkeys.commands."launch-wezterm" = {
      name = "Launch WezTerm";
      key = "Ctrl+Alt+Y";
      command = "wezterm";
    };

    panels = [
      {
        location = "bottom";
        height = 40;
        floating = true;
      }
    ];

    shortcuts = {
      "org.kde.konsole.desktop"."_launch" = [];
      "services/org.kde.konsole.desktop"."_launch" = [];
      "kwin"."Launch Terminal" = [];
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      wallpaper = wallpaper;
    };
  };

  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];

      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";

        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"];
            };

            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"${flakePath}\").nixosConfigurations.${hostname}.options";
              };

              "home-manager" = {
                "expr" = "(builtins.getFlake \"${flakePath}\").homeConfigurations.\"${username}@${hostname}\".options";
              };
            };
          };
        };

        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
          "editor.tabSize" = 2;
        };
      };
    };
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ../config/wezterm/.wezterm.lua;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.home-manager.enable = true;
}
