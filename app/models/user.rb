class User < ActiveRecord::Base
	has_many :addresses, dependent: :nullify
	has_many :antibodies, dependent: :nullify
	has_many :antibody_purifications, dependent: :nullify
	has_many :attachments, dependent: :nullify
	has_many :barcodes, dependent: :nullify
	has_many :biosamples, dependent: :nullify
	has_many :biosample_term_names, dependent: :nullify
	has_many :biosample_types, dependent: :nullify
	has_many :chromosomes, dependent: :nullify
	has_many :cloning_vectors, dependent: :nullify
	has_many :concentration_units, dependent: :nullify
	has_many :construct_tags, dependent: :nullify
	has_many :crispr_modification, dependent: :nullify
	has_many :crispr_constructs, dependent: :nullify
	has_many :data_storages, dependent: :nullify
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
	has_many :sequencing_runs, dependent: :nullify
	has_many :targets, dependent: :nullify
	has_many :sequencing_library_prep_kits
	has_many :single_cell_sortings
	has_many :vendors, dependent: :nullify
	has_many :wells, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	validates :email, presence: true #already required, but for some reason with Devise the asterisk doesn't show up on the form.
	validates :first_name, presence: true #already required, but for some reason with Devise the asterisk doesn't show up on the form.
	validates :last_name, presence: true #already required, but for some reason with Devise the asterisk doesn't show up on the form.

	VIEWER_ROLE = 1
	MANAGER_ROLE = 5
	ADMIN_ROLE = 10
	ROLES = { :VIEWER_ROLE => VIEWER_ROLE, :MANAGER_ROLE => MANAGER_ROLE, :ADMIN_ROLE => ADMIN_ROLE }

	scope :archived, lambda { where.not(archived_at: nil) }
	scope :admins, lambda { where(role: ADMIN_ROLE, archived_at: nil) }
	scope :managers, lambda { where(role: MANAGER_ROLE ).where(archived_at: nil) }
	scope :viewers, lambda { where(role: VIEWER_ROLE ).where(archived_at: nil) }
	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 

	def display
		return "#{first_name} #{last_name}"
	end

	def generate_api_key
    if not role >= User::MANAGER_ROLE
      raise Pundit::NotAuthorizedError  
    end 
		self.update_column(:api_key, SecureRandom.hex(16))
	end

	def remove_api_key
		self.update_column(:api_key, nil)
	end

	def archive
		self.update(archived_at: Time.now)
	end
	
	def unarchive
		self.update(archived_at: nil)
	end

	def to_s
		"#{email}"
	end

	def active_for_authentication?
		#As stated in Rails 4 In Action:
		#
		#Devise determines if a user can sign in to your app with a method called
		# active_for_authentication?. Each of the Devise strategies we listed in chapter 6
		# (lockable, confirmable, and so on) can add conditions to determine whether or not
		# a user is able to sign in—for example, the lockable strategy will overwrite this
		# Listing 7.64 Testing that archived users can’t sign in
		# Licensed to Nathaniel Watson <nathan.watson86@gmail.com>
		# 212 CHAPTER 7 Basic access control
		# active_for_authentication? method to return false if the user’s record is locked.
		# If the method returns false, then the user is not allowed to sign in.
		# You can write your own active_for_authentication? method in your User
		# model to disallow authentication if a user is archived.
		super && archived_at.nil?
	end

	def inactive_message
		#Extending Devise's inactive_message() method. As stated in Rails 4 In Action, "This method will get called by Devise when 
		# active_for_authentication? returns False, and it should return the translation key of the message that should be displayed
		# to the user." (p. 212). 
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
