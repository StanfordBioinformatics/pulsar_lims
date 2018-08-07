# This initializer is used to initialize a constant named INPUT_DEFAULTS that stores a hash
# of all the default values for for inputs. It is expected that there is a file in this directory
# by the name of form_input_defaults.yaml that stores dictionaries in records named after model
# classes. For example, to get all the form defaults for a GelLane, that would be INPUT_DEFAULTS["GElLane"].
# The dictionary keys are the attribute names of the model record. 

# A good reason for storing default configuration this way is that it doesn't hard-code the values in
# the form views, allowing for multiple deployments of this LIMS, each with its own user-defined defaults.
# The form_input_defaults.yaml should not be version-controlled so that each deployment of this LIMS
# can define it on its own. 

require 'yaml'

conf_file = "config/initializers/form_input_defaults.yaml"
input_defaults = {}
if File.exist?(conf_file)
  input_defaults = YAML.load_file(conf_file)
end
INPUT_DEFAULTS = input_defaults
# INPUT_DEFAULTS can be accessed in views, controllers, ... but is really meant to be used only in
# form views.
