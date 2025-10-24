{ config }:
{
  enable = true;
  settings.user = {
    name = "Andres Vargas";
    email = "devandresvargas@gmail.com";
  };
  settings = {
    init = {
      defaultBranch = "main";
    };
    branch = {
      autosetuprebase = "always";
    };
    pull = {
      rebase = true;
    };
  };
}
