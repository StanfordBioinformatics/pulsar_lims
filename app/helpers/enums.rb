module Enums
  #Defines several constants to serve as enums. These are references in models during validation
  # of property values.

  DURATION_UNITS = ["second", "minute", "hour", "day"]

  GENDERS = ["female", "male", "mixed", "unknown"]

  TISSUE_PRESERVATION_METHODS = ["cryopreservation", "flash-freezing", "fresh"]

  TREATMENT_TYPES = ["antibody","chemical","exposure","infection","injection","irradiation","protein","transplantation"]

end
