class User < ActiveRecord::Base
	has_many :antibodies, dependent: :nullify
	has_many :antibody_purifications, dependent: :nullify
	has_many :attachments, dependent: :nullify
	has_many :barcodes, dependent: :nullify
	has_many :biosamples, dependent: :nullify
	has_many :biosample_term_names, dependent: :nullify
	has_many :biosample_types, dependent: :nullify
	has_many :chromosomes, dependent: :nullify
	has_many :cloning_vectors, dependent: :nullify
	has_many :construct_tags, dependent: :nullify
	has_many :crisprs, dependent: :nullify
	has_many :crispr_constructs, dependent: :nullify
	has_many :documents, dependent: :nullify
	has_many :document_types, dependent: :nullify
	has_many :donors, dependent: :nullify
	has_many :donor_constructs, dependent: :nullify
	has_many :experiment_types, dependent: :nullify
	has_many :isotypes, dependent: :nullify
	has_many :libraries, dependent: :nullify
	has_many :library_fragmentation_methods, dependent: :nullify
	has_many :nucleic_acid_terms, dependent: :nullify
	has_many :organisms, dependent: :nullify
	has_many :paired_barcodes, dependent: :nullify
	has_many :plates, dependent: :nullify
	has_many :reference_genomes, dependent: :nullify
	has_many :sequencing_centers, dependent: :nullify
	has_many :sequencing_platforms, dependent: :nullify
	has_many :sequencing_requests, dependent: :nullify
	has_many :targets, dependent: :nullify
	has_many :sequencing_library_prep_kits
	has_many :vendors, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	VIEWER_ROLE = 1
	MANAGER_ROLE = 5
	ADMIN_ROLE = 10
	ROLES = { :VIEWER_ROLE => VIEWER_ROLE, :MANAGER_ROLE => MANAGER_ROLE, :ADMIN_ROLE => ADMIN_ROLE }

	scope :archived_users, lambda { where.not(archived_at: nil) }
	scope :admin_users, lambda { where(role: ADMIN_ROLE, archived_at: nil) }
	scope :regular_users, lambda { where.not(role: ADMIN_ROLE ).where(archived_at: nil) }


	def self.policy_class
		ApplicationPolicy
	end 

	def archive
		self.update(archived_at: Time.now)
	end

	def to_s
		"#{email}"
	end

	def active_for_authentication?
		super && archived_at.nil?
	end

	def inactive_message
		archived_at.nil? ? super : :archived
	end

	def role_name
		if role == VIEWER_ROLE
			return "viewer"
		elsif role == MANAGER_ROLE
			return "manager"
		elsif role == ADMIN_ROLE
			return "admin"
		else
			raise Exception, "Unknown role for user #{email}."
		end
	end

	def admin?
		if role == ADMIN_ROLE
			return true
		else
			return false
		end
	end

	def manager?
		if role == MANAGER_ROLE
			return true
		else
			return false
		end
	end

	def viewer?
		if role == VIEWER_ROLE
			return true
		else
			return false
		end
	end

end
