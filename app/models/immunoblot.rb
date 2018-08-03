require 'elasticsearch/model'
class Immunoblot < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks                                                              
  include ModelConcerns                                                                                
  ABBR = "IB"                                                                                          
  DEFINITION = "Immunoblot" 

  belongs_to :analyst, class_name: "User"
  belongs_to :primary_antibody, class_name: "Antibody"
  belongs_to :primary_antibody_concentration_units, class_name: "Unit"
  belongs_to :secondary_antibody, class_name: "Antibody"
  belongs_to :secondary_antibody_concentration_units, class_name: "Unit"
  belongs_to :user
  belongs_to :agarose_gel
  has_many :documents

  scope :persisted, lambda { where.not(id: nil) }                                                      
                                                                                                       
  def self.policy_class                                                                                
    ApplicationPolicy                                                                                  
  end 
end
