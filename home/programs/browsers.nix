{ pkgs, config, ... }: {
  programs.firefox = {
    enable = true;
    profiles.nikita = {
      containers = {
        personal = {
          id = 0;
          name = "Personal";
          color = "pink";
          icon = "fingerprint";
        };
        work = {
          id = 1;
          name = "Work";
          color = "orange";
          icon = "briefcase";
        };
        banking = {
          id = 2;
          name = "Banking";
          color = "green";
          icon = "dollar";
        };
        shopping = {
          id = 3;
          name = "Shopping";
          color = "turquoise";
          icon = "cart";
        };
      };
  };
}
