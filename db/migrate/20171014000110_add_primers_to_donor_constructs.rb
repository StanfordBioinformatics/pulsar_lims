class AddPrimersToDonorConstructs < ActiveRecord::Migration
  def change
    add_column :donor_constructs, :primer_left_forward, :string
    add_column :donor_constructs, :primer_left_reverse, :string
    add_column :donor_constructs, :primer_right_forward, :string
    add_column :donor_constructs, :primer_right_reverse, :string
  end
end
