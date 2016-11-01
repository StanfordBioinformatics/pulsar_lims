class AddUserToReferenceGenomes < ActiveRecord::Migration
  def change
    add_reference :reference_genomes, :user, index: true
    add_foreign_key :reference_genomes, :users
  end
end
