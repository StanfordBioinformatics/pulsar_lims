class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.string :content_type
      t.binary :data
      t.references :document_type, index: true

      t.timestamps
    end
  end
end
