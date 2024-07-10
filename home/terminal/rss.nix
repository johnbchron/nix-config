{ pkgs, ... }: {
  home.packages = with pkgs; [
    nom
  ];

  home.file.nom-config = {
    target = ".config/nom/config.yml";
    text = pkgs.lib.generators.toYAML {} {
      "configpath" = "/home/jlewis/.config/nom/config.yml";
      "showfavourites" = false;
      "version" = "";
      "feeds" = [
        {
          "name" = "xkcd";
          "url" = "https://xkcd.com/rss.xml";
        }
        {
          "name" = "Ivan Petkov";
          "url" = "https://ipetkov.dev/atom.xml";
        }
      ];
      "theme" = {
        "glamour" = "dark";
        "titleColor" = "62";
        "filterColor" = "62";
        "selectedItemColor" = "170";
      };
    };
  };
}
