module Enums
  #Defines several constants to serve as enums. These are references in models during validation
  # of property values.

  CONCENTRATION_INSTRUMENTS = ["Bioanalyzer", "Qubit"]

  CRISPR_MOD_CATEGORIES = ["deletion", "interference", "insertion", "mutagenesis", "replacement"]

  CRISPR_MOD_PURPOSE = ["activation", "analysis", "overexpression", "repression", "tagging", "validation"]

  DURATION_UNITS = ["second", "minute", "hour", "day"]

  GENDERS = ["female", "male", "mixed", "unknown"]

  SEQUENCING_STATUS = ["not started", "started", "trouble-shooting", "failed", "finished"]

  STARTING_AMOUNT_UNITS = ["cells", "cells/ml", "g", "items", "mg", "whole animals", "whole embryos", "μg"]

  TISSUE_PRESERVATION_METHODS = ["cryopreservation", "flash-freezing", "fresh"]

  TREATMENT_TYPES = ["antibody","chemical","exposure","infection","injection","irradiation","protein","transplantation"]

  UNIT_TYPES = ["concentration", "items", "mass", "volume"]

end
