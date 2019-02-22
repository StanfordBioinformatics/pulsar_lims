class AddCaptionToGelImages < ActiveRecord::Migration
  def change
    add_column :gel_images, :caption, :text
  end
end
