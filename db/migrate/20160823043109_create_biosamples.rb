class CreateBiosamples < ActiveRecord::Migration
  def change
    create_table :biosamples do |t|
      t.string :submitter_comments
      t.string :lot_identifier
      t.string :source_product_identifier
      t.string :term_name
      t.string :term_identifier
      t.string :description
      t.integer :passage_number
      t.date :culture_harvest_date
      t.string :encid

      t.timestamps
    end
  end
end
