class CrisprConstruct < ActiveRecord::Base
	attr_accessor :construct_tag_ids
	has_and_belongs_to_many :construct_tags
	has_many :crisprs
  belongs_to :user
  belongs_to :target
  belongs_to :cloning_vector
  belongs_to :vendor

	validates :cloning_vector, presence: true
	validates :name, presence: true, uniqueness: true
	validates :target, presence: true	
	validates :vendor, presence: true

	accepts_nested_attributes_for :construct_tags, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end

  def construct_tag_ids=(ids)
    ids.each do |i| 
      if i.present?
        construct = ConstructTag.find(i) 
        if self.construct_tags.present? and self.construct_tags.include?(construct)
          next
        end 
        self.construct_tags << construct
      end 
    end 
  end 
end
