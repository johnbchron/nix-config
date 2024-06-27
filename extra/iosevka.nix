{
  privateBuildPlan = {
    family = "Iosevka Custom";

    spacing = "term";
    serifs = "sans";
    noCvSs = true;
    exportGlyphNames = false;

    variants = {
      inherits = "ss03";
      design = {
        g = "single-storey-serifless";
        j = "serifless";
        l = "serifed-asymmetric";
        y = "cursive-serifless";
        z = "curly-serifless";
        six = "straight-bar";
        nine = "straight-bar";
        # punctuation-dot = "round";
        asterisk = "turn-hex-high";
        # underscore = "low";
        brace = "curly";
        guillemet = "curly";
        # ampersand = "closed";
        question = "smooth";
        # micro-sign = "tailed-serifless";
        lig-equal-chain = "without-notch";
        lig-hyphen-chain = "without-notch";
        # lig-double-arrow-bar = "without-notch";
      };
    };
  };
  set = "custom";
}
