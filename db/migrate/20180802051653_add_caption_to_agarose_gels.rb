class AddCaptionToAgaroseGels < ActiveRecord::Migration
  def change
    add_column :agarose_gels, :caption, :text
  end
end
