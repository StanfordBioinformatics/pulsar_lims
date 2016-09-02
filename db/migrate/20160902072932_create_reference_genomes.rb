class CreateReferenceGenomes < ActiveRecord::Migration
  def change
    create_table :reference_genomes do |t|
      t.string :name, index: true
      t.string :url

      t.timestamps
    end
  end
end
