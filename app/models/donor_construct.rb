class DonorConstruct < ActiveRecord::Base
	ABBR = "DONC"
	DEFINITION = "A DNA construct (i.e. plasmid) that you or a third party created using a Cloning Vector for a CRISPR experiment, or some other type of genetic modification experiment, which contains the sequence to insert into the genome for editing.  Model abbreviation: #{ABBR}"
	attr_accessor :construct_tag_ids

	has_and_belongs_to_many :construct_tags
	has_many :crispr_modifications
  belongs_to :user
  belongs_to :cloning_vector
  belongs_to :vendor
  belongs_to :target

	validates :name, presence: true
	validates :cloning_vector, presence: true
  validates :primer_left_forward, format: { with: /\A[acgtnACGTN]+\z/, message: "can only contain characters in the set ACTGN" }, allow_blank: true
  validates :primer_left_reverse, format: { with: /\A[acgtnACGTN]+\z/, message: "can only contain characters in the set ACTGN" }, allow_blank: true
  validates :primer_right_forward, format: { with: /\A[acgtnACGTN]+\z/, message: "can only contain characters in the set ACTGN" }, allow_blank: true
  validates :primer_right_reverse, format: { with: /\A[acgtnACGTN]+\z/, message: "can only contain characters in the set ACTGN" }, allow_blank: true
	validates :insert_sequence, format: { with: /\A[acgtnACGTN]+\z/, message: "can only contain characters in the set ACTGN" }, allow_blank: true
	validates :vendor_id, presence: true
	validates :target_id, presence: true

	accepts_nested_attributes_for :construct_tags, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

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
