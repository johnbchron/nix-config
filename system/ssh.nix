{ ... }: {
  programs.ssh = {
    extraConfig = ''
      Host bumble
        HostName 3.20.224.129
    '';

    knownHostsFiles = [ ./known_hosts ];
  };

  users.users.jlewis.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6y2a6lcW8UzwpRWDGGnmtInWpjm+eDhedAxCaSy9VP"
  ];
}
