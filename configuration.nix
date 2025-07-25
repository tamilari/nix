{ config, pkgs, systemSettings, userSettings, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.shells = with pkgs; [ bash ];
  users.defaultUserShell = pkgs.bash;

  networking.hostName = systemSettings.hostname;

  networking.networkmanager.enable = true;

  time.timeZone = systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  services.xserver.xkb = {
    layout = systemSettings.keyboard;
    variant = "";
  };

  console.keyMap = systemSettings.keyboard;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [];

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkVcLdjykFQR58sSfQbyfayn44C4YV9UUkXtJwdAIxMq+kv9ieXvB1jlnFU7QnZA0J76QXRN9xE7fERrGoRYIJJEGnvtFv0GUqDFAw5l0kXmG3lRcPCBRXFW+GWZlGUUFXOjTI5wyI/bXarxLDM8QvVE0oVMV80KE1Vglr1UEeKCvrH3+aWQjUW5GwNB7RefxO3f86U4LDqESL+XM3iVQ9ji80/nrY7zemj7nJ3GViEbYatcttbwW9u2gPgnZfR/fs/FAsFAyMy/kIqeCnlZE6taZ4kl7Fpji0lfFTHPa4CCG6WT1qn7Z4YZZTBDfsMZQU7sxBzjVxLocA8PbylEbFuPQG2l1cJ5r+/LaD58frEzTLAPLuhkQSfmQhLpx42FNxSfZMJq3WOVxdetRvm78KVi49rr5EJmPZrztmTL70W0cxEzrBHlwm4hjuc75kfT6gQvCB8bROq9d5iOeqPdeJD9QkOJ/0z5cPJigfh3Xk5RmNKgL2IN8Jsw/YKq9tekU= tamino"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gcc
    zulu24
    python3Full

    dunst
    libnotify
    pipewire
    xdg-desktop-portal
    hyprpolkitagent
    noto-fonts
    firefox
    waybar
    kitty
    rofi-wayland
    wofi
  ];

  programs.hyprland.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
