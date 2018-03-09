module Enums
  #Defines several constants to serve as enums. These are references in models during validation
  # of property values.

  TREATMENT_TYPES = ["antibody","chemical","exposure","infection","injection","irradiation","protein","transplantation"]
  DURATION_UNITS = ["second", "minute", "hour", "day"]
  TISSUE_PRESERVATION_METHODS = ["cryopreservation", "flash-freezing"]

end
