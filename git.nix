{ config, pkgs, ... }:
let

in  
{
  programs.git = {
    enable = true;
    userName = "Tamino";
    userEmail = "111866656+tamilari@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}

