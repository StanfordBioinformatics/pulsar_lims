class PairedBarcode < ActiveRecord::Base
	attr_accessor :add_paired_barcodes #used in the form partial so the user can input multiple pairs to add. 
	has_many :libraries
  belongs_to :user
  belongs_to :index1, class_name: "Barcode"
  belongs_to :index2, class_name: "Barcode"
  belongs_to :sequencing_library_prep_kit

	validates :name, uniqueness: true, presence: true
	validates :sequencing_library_prep_kit, presence: true
	validates :index1_id, presence: true
	validates :index2_id, presence: true

	before_save :verify_sequencing_kit, :verify_index_number

	scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 

	def to_s
		display()
	end

	def self.make_name(index1_name, index2_name)
		return "#{index1_name}-#{index2_name}"
	end

	def display
		seq = get_sequence()
		return "#{name} #{seq}"
	end

	def get_sequence
		return "#{index1.sequence}-#{index2.sequence}"
	end

 	private 
    def verify_sequencing_kit
      if self.index1.sequencing_library_prep_kit.id != self.index2.sequencing_library_prep_kit.id
        self.errors.add(:index1,": The sequencing library prep kit of the referenced barcode does not match that of index2.")
        self.errors.add(:index2,": The sequencing library prep kit of the referenced barcode does not match that of index1.")
        return false
			elsif self.index1.sequencing_library_prep_kit.id != self.sequencing_library_prep_kit.id
				self.errors.add(:sequencing_library_prep_kit,"does not match the kit specified by the barcodes referenced by index1 and index2.")
				return false
      end 
    end 

		def verify_index_number
			if self.index1.index_number != 1
				self.errors.add(:index1, ": The referenced barcode does not have the index_number attribute set to 1.")
				return false
			end
			if self.index2.index_number != 2
				self.errors.add(:index2, ": The referenced barcode does not have the index_number attribute set to 2.")
				return false
			end
		end
end
