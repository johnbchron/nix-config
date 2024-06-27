{ ... }: {
  programs.ssh = {
    extraConfig = ''
      Host bumble
        HostName ec2-18-219-61-224.us-east-2.compute.amazonaws.com
        User root
        IdentityFile /home/jlewis/keys/bumble-key.pem
    '';

    knownHostsFiles = [ ./known_hosts ];
  };

  users.users.jlewis.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6y2a6lcW8UzwpRWDGGnmtInWpjm+eDhedAxCaSy9VP"
  ];
}
