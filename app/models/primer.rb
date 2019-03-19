require 'elasticsearch/model'

class Primer < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "PR"
  DEFINITION = "A PCR primer."
  FORWARD_D = "forward"
  REVERSE_D = "reverse"
  DIRECTION = [FORWARD_D, REVERSE_D]

  belongs_to :user
  belongs_to :ordered_from, class_name: "Vendor"
  belongs_to :designed_by, class_name: "User"
  belongs_to :target

  validates :direction, presence: true, inclusion: {in: DIRECTION, message: "must be a value from the set #{DIRECTION}."}
  validates :sequence, presence: true, format: { with: /\A[acgtnACGTN,]+\z/, message: "can only contain characters in the set ACTGN (case in-sensitive)."}

  scope :forward, lambda {where(direction: FORWARD_D)}
  scope :reverse, lambda {where(direction: REVERSE_D)}

  def self.policy_class
    ApplicationPolicy
  end

  def to_label
     # Shadows the to_label method defined in /app/models/concerns/model_concerns.
     display = self.get_record_id() + " "
     if self.name.present?
       display += self.name  + " "
     end
     return display += self.sequence
  end
end
