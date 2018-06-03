
"""
Contains utilities for working in the Rails console.
"""

def get_all_models
  #Omits HABTM models.
  Rails.application.eager_load!
  res = ActiveRecord::Base.descendants.reject {|m| m.name.starts_with?("HABTM")}
end

def import_into_elasticsearch
  models = get_all_models()
  models.each do |m|
    if m.respond_to?(:import) 
      puts "Importing model #{m.name}."
      m.import(force: true)
    end
  end
end
