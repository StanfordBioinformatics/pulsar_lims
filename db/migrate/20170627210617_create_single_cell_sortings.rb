class CreateSingleCellSortings < ActiveRecord::Migration
  def change
    create_table :single_cell_sortings do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
