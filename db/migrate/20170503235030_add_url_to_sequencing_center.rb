class AddUrlToSequencingCenter < ActiveRecord::Migration
  def change
    add_column :sequencing_centers, :url, :string
  end
end
