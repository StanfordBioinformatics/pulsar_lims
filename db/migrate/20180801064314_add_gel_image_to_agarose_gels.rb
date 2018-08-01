class AddGelImageToAgaroseGels < ActiveRecord::Migration
  def change
    add_column :agarose_gels, :gel_image, :string
  end
end
