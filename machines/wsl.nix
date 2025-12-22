{ pkgs, currentSystemUser, ... }: {
  imports = [
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = currentSystemUser;
    startMenuLaunchers = true;
    interop.register = true;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [
    fastfetch
    kopia
    gnumake
    gcc
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
  ];

  environment.variables = {
    ALL_PROXY = "socks5://127.0.0.1:65000";
    HTTP_PROXY = "socks5://127.0.0.1:65000";
    HTTPS_PROXY = "socks5://127.0.0.1:65000";
  };

  system.stateVersion = "25.11";
}
