require 'elasticsearch/model'
class GelLane < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks                                                              
  include ModelConcerns 
  ABBR = "GL"                                                                                          
  DEFINITION = "Represents a lane from an aragose gel. Model abbreviation: #{ABBR}"

  belongs_to :gel
  belongs_to :biosample
  belongs_to :user
  belongs_to :sample_concentration_units, class_name: "Unit"

  validates :biosample, presence: true
  validates :lane_number, presence: true, numericality: {greater_than: 0}
  validates_uniqueness_of :lane_number, scope: [:gel]
  validates :sample_concentration, numericality: {greater_than: 0}, allow_blank: true
  validates :sample_concentration, presence: {message: "must be specified when the units are set."}, if: "sample_concentration_units_id.present?"
  validates :sample_concentration_units_id, presence: {message: "must be specified when the concentration is specified."}, if: "sample_concentration.present?"
  validate :validate_sample_concentration_units, on: :save

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class                                                                                
    ApplicationPolicy                                                                                  
  end 

  def display
    self.lane_number
  end

  private

  def validate_sample_concentration_units
    if self.sample_concentration_units.unit_type != "concentration"
      self.errors.add(:sample_concentration_units_id, "must be a concentration type of unit.")
      return false
    end
  end
end
