require 'elasticsearch/model'
class CrisprConstruct < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CC"
  DEFINITION = "A DNA construct (i.e. plasmid) that you or a third party created using a Cloning Vector for a CRISPR experiment, and that contains a single guide sequence. This construct is separate from a Donor Construct, which contains the sequence to insert in the genome for genome editing.  Model abbreviation: #{ABBR}"
  attr_accessor :construct_tag_ids
  has_and_belongs_to_many :construct_tags
  has_and_belongs_to_many :crispr_modifications
  belongs_to :sent_to, class_name: "Address"
  belongs_to :user
  belongs_to :target
  belongs_to :cloning_vector
  belongs_to :vendor

  validates :cloning_vector, presence: true
  validates :guide_sequence, presence: true, format: { with: /\A[acgtnACGTN]+\z/, message: "can only contain characters in the set ACTGN" }
  validates :name, presence: true, uniqueness: true
  validates :target, presence: true  
  validates :vendor, presence: true

  accepts_nested_attributes_for :construct_tags, allow_destroy: true

  scope :persisted, lambda { where.not(id: nil) }
  scope :non_persisted, lambda { where(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def construct_tag_ids=(ids)
    ids.each do |i| 
      if i.present?
        construct = ConstructTag.find(i) 
        if self.construct_tags.include?(construct)
          next
        end 
        self.construct_tags << construct
      end 
    end 
  end 
end
