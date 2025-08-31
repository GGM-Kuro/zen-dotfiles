{config}: {
  enable = true;
  userName = "Andres Vargas";
  userEmail = "devandresvargas@gmail.com";
  extraConfig = {
    init = {defaultBranch = "main";};
    branch = {autosetuprebase = "always";};
    pull = {rebase = true;};
  };
}
