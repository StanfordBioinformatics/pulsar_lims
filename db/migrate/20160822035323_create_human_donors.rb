class CreateHumanDonors < ActiveRecord::Migration
  def change
    create_table :human_donors do |t|
      t.string :encode_id
      t.string :encode_alias
      t.string :string

      t.timestamps
    end
  end
end
