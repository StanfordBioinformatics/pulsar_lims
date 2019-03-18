require 'elasticsearch/model'
class BiosampleType < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "BTY"
  DEFINITION = "Broad category of the type of biosample, such as tissue, primary cell, immortalized cell line, ... Model abbreviation: #{ABBR}"
  # NOTE: The 'name' property corresponds to the ENCODE Portal's 'classification' property
  # in the biosample_type profile. 
  default_scope {order("lower(name)")}
  has_many :biosamples
  belongs_to :user

  validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 

  def cultured?
    if tissue?
      return false
    end
    return true
  end

  def self.get_biosample_term_names(biosample_type_id)
    #Given a biosample_type, retrieves all possible biosample_term_names that can be used to indicate the term.
    biosample_type = BiosampleType.find(biosample_type_id)
    biosample_type_name = biosample_type.name

    tissue = BiosampleType.find_by!(name: "tissue") #Uberon
    whole_organism = BiosampleType.find_by!(name: "whole organisms") #Uberon
    primary_cell = BiosampleType.find_by!(name: "primary cell") #CL 
    stem_cell = BiosampleType.find_by!(name: "stem cell") #CL 
    cell_line = BiosampleType.find_by!(name: "cell line") #EFO
    in_vitro_differentiated_cell = BiosampleType.find_by!(name: "in vitro differentiated cells") #CL or EFO

    biosample_term_name_selection = BiosampleTermName.all
    if [tissue.name,whole_organism.name].include?(biosample_type_name)
      biosample_term_name_selection = BiosampleTermName.uberon
    elsif [primary_cell.name, stem_cell.name].include?(biosample_type_name)
      biosample_term_name_selection = BiosampleTermName.cl
    elsif cell_line.name == biosample_type_name
      biosample_term_name_selection = BiosampleTermName.efo
    elsif biosample_type_name == in_vitro_differentiated_cell.name
      biosample_term_name_selection = BiosampleTermName.cl.merge(BiosampleTermName.efo)
    end 
    return biosample_term_name_selection
  end

end
