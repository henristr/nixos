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
    gcc
    go
    gopeed
    nerd-fonts.jetbrains-mono
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
        bitwarden
        ublock-origin

        (pkgs.stdenv.mkDerivation {
          name = "gopeed-extension";
          src = pkgs.fetchurl {
            url = "https://mozilla.org";
            hash = "sha256-qMTnSHR88zowrEVpGnWGdRlo9C+jKkVeE2bVwUFHFIg=";
          };
          buildCommand = ''
            dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            mkdir -p "$dst"
            cp $src "$dst/{c5d69a8f-2ed0-46a7-afa4-b3a00dc58088}.xpi"
          '';
        })
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
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

  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = pkgs.lib.importTOML ../config/starship/starship.toml;
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
