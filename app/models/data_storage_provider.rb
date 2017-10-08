class DataStorageProvider < ActiveRecord::Base
	has_many :data_storages, dependent: :nullify
  belongs_to :user

	validates :name, presence: true, uniqueness: true

  def self.policy_class
    ApplicationPolicy
  end
end
