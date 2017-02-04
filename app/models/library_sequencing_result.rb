class LibrarySequencingResult < ActiveRecord::Base
  belongs_to :sequencing_result
  belongs_to :library

	validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  def self.policy_class
    ApplicationPolicy
  end 
end
