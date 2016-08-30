class CreateHumanGenes < ActiveRecord::Migration
  def change
    create_table :human_genes do |t|
      t.string :encode_identifier, index: true
      t.string :name

      t.timestamps
    end
  end
end
