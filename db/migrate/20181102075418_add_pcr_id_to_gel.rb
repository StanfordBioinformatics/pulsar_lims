class AddPcrIdToGel < ActiveRecord::Migration
  def change
    add_reference :gels, :pcr, index: true, foreign_key: true
  end
end
