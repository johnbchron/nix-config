
super: prev: let
  consolas-based = {
    inherits = "ss03";
    design = {
      g = "single-storey-serifless";
      j = "serifless";
      l = "serifed-asymmetric";
      y = "cursive-serifless";
      z = "curly-serifless";

      capital-g = "toothed-serifless-capped";
      capital-m = "hanging-serifless";

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

  anonymous-pro-based = {
    inherits = "ss02";
    design = {
      capital-c = "serifless";
      capital-s = "serifless";
      
      c = "serifless";
      f = "flat-hook-serifless-crossbar-at-x-height";
      r = "top-serifed";
    
      asterisk = "turn-hex-high";
      brace = "curly";
      question = "smooth";
      
      braille-dot = "square";

      lig-equal-chain = "without-notch";
      lig-hyphen-chain = "without-notch";
    };
  };

  menlo-based = {
    inherits = "ss04";

    design = {
      braille-dot = "square";

      asterisk = "turn-hex-high";
      brace = "curly";

      lig-equal-chain = "without-notch";
      lig-hyphen-chain = "without-notch";
    };
  };

  buildPlan = {
    family = "Iosevka Custom";

    serifs = "sans";
    noCvSs = true;
    exportGlyphNames = false;

    variants = menlo-based;
  };
in {
  iosevka-term-custom = prev.iosevka.override  {
    privateBuildPlan = buildPlan // {
      family = "Iosevka Term Custom";
      spacing = "term";
      noLigation = true;
    };
    set = "TermCustom";
  };
  iosevka-custom = prev.iosevka.override  {
    privateBuildPlan = buildPlan;
    set = "Custom";
  };
}
