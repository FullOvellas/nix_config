{
  networking = {
    # Enable networking
    networkmanager.enable = true;
    hostName = "nixos"; # Define your hostname.
    hosts = {
      "127.0.0.1" = [
        "kafka"
        "mongo"
        "datachain-local-mongo-1"
        "redis-node-1"
        "redis-node-2"
        "redis-node-3"
        "redis-node-4"
        "redis-node-5"
        "redis-node-6"
        "cvs"
      ];
    };
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Open ports in the firewall.
    # firewall = {
    #   allowedTCPPorts = [ 8096 32400 ];
    #   allowedUDPPorts = [ 8096 32400 ];
    # Or disable the firewall altogether.
    #   enable = false;
    # };

    # Configure network proxy if necessary
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };
}
