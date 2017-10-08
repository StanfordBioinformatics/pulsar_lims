class DataStorage < ActiveRecord::Base
  belongs_to :user
	belongs_to :data_storage_provider

	validates :name, presence: true, uniqueness: true

  def self.policy_class
    ApplicationPolicy
  end 
end
