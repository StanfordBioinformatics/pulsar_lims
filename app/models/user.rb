class User < ActiveRecord::Base
	has_many :libraries, dependent: :nullify
	has_many :biosamples, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	scope :archived_users, lambda { where.not(archived_at: nil) }
	scope :admin_users, lambda { where(admin: true,archived_at: nil) }
	scope :regular_users, lambda {where(admin: false, archived_at: nil) }

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

end
