class AddUserToExperimentTypes < ActiveRecord::Migration
  def change
    add_reference :experiment_types, :user, index: true
    add_foreign_key :experiment_types, :users
  end
end
