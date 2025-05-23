{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fullovellas = {
    isNormalUser = true;
    description = "Sergio Alonso";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
    ];
  };
}
