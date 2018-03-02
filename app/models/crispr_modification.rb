class CrisprModification < ActiveRecord::Base
	#crisprs only belong to biosamples.
	ABBR = "CRISPR"
	DEFINITION = "A genetic modification carried out using CRISPR technology.  This object links together one or more CRISPR Construct objects (each containing an individual guide sequence), and a Donor Construct object (containing the donor sequence). A new CRISPR Modificition is created at the Biosample level.  Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :biosample
  belongs_to :donor_construct
	belongs_to :genomic_integration_site, class_name: "GenomeLocation"

	has_many :pcr_validations, class_name: "Pcr", dependent: :nullify
  has_and_belongs_to_many :crispr_constructs
	validates :name, presence: true, uniqueness: true
	validates :biosample, presence: true
	validates :crispr_constructs, presence: true
	validates :donor_construct, presence: true

	accepts_nested_attributes_for :genomic_integration_site, allow_destroy: true
	accepts_nested_attributes_for :crispr_constructs, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	validate :verify_target 

	def self.policy_class
		ApplicationPolicy
	end

  def crispr_construct_ids=(ids)
    ids.each do |i| 
      if i.present?
        construct = CrisprConstruct.find(i) 
        if self.crispr_constructs.include?(construct)
          next
        end 
        self.crispr_constructs << construct
      end 
    end 
  end

	protected
		def verify_target
			#Verifies that all crispr_constructs and the donor_construct all have the same target specified. 
			self.crispr_constructs.each do |cc|
				if cc.target.id != self.donor_construct.target.id
					self.errors.add(:target_id,"must be the same between the Crispr Construct and the Donor Construct.")
					return false
				end
			end
		end
end
