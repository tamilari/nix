{ config, pkgs, lib, systemSettings, userSettings, nixpkgs, home-manager, hyprland, ... }:
let
  myAliases = {
    "ll" = "ls -l";
    "lal" = "ls -al";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";    
    "....." = "cd ../../../..";
    "nixs" = "nix search nixpkgs";
  };
in
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  # try to only type ssh password once
  #services.ssh-agent.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./git.nix
    ./hyprland.nix
    #({ config, pkgs, lib, systemSettings, hyprland, ... }:
    #  import ./hyprland.nix {
    #    inherit config pkgs lib systemSettings hyprland;
    #  }
    #)
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    nautilus
    libreoffice
    pavucontrol
    wl-gammarelay-rs

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ]);

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tamino/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.waybar = {
    enable = true;
    settings = import ./waybar/config.nix;
    style = ./waybar/style.css;
  };

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.vim = {
    enable = true;
    settings = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };
    extraConfig = ''
      autocmd FileType nix setlocal tabstop=2 shiftwidth=2 expandtab
    '';
  };

  programs.kitty.enable = true;
}

