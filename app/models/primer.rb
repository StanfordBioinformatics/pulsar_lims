require 'elasticsearch/model'

class Primer < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks                                                              
  include ModelConcerns     
  ABBR = "PR"                                                                                        
  DEFINITION = "A PCR primer."

  belongs_to :user
  belongs_to :designed_by, class_name: "User"
  belongs_to :target
  FORWARD_D = "forward"
  REVERSE_D = "reverse"
  DIRECTION = [FORWARD_D, REVERSE_D]

  validates :direction, presence: true, inclusion: {in: DIRECTION, message: "must be a value from the set #{DIRECTION}."}
  validates :sequence, presence: true, format: { with: /\A[acgtnACGTN,]+\z/, message: "can only contain characters in the set ACTGN (case in-sensitive)."} 

  def self.policy_class                                                                             
    ApplicationPolicy                                                                               
  end 

end
