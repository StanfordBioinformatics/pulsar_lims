class RemoveGelImageFromGels < ActiveRecord::Migration
  def change
    remove_column :gels, :gel_image
  end
end
