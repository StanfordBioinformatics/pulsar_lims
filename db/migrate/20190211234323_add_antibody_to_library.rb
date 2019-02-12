class AddAntibodyToLibrary < ActiveRecord::Migration
  def change
    add_reference :libraries, :antibody, index: true, foreign_key: true
  end
end
