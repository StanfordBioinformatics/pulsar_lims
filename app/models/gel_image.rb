class GelImage < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks                                                              
  include ModelConcerns                                                                                
  ABBR = "GELI"                                                                                         
  DEFINITION = "Represents an image of an agarose or polyacrylamide gel used in electrophoresis. Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :gel

  def self.policy_class                                                                                
    ApplicationPolicy                                                                                  
  end 
end
