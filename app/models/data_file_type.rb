class DataFileType < ActiveRecord::Base
  belongs_to :user
	has_many :file_references

	validates :name, presence: true, uniqueness: true

  def self.policy_class
    ApplicationPolicy
  end 

end
