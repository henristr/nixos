{
  config,
  pkgs,
  hostname,
  ...
}: let
  hostModules = {
    vm = [];
    smtpad = [../modules/gaming.nix ../modules/jetbrains.nix];
  };

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

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      wallpaper = wallpaper;
    };

    panels = [
      {
        location = "bottom";
        height = 40;
        floating = true;
      }
    ];
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.home-manager.enable = true;
}
