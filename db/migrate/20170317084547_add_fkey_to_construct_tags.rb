class AddFkeyToConstructTags < ActiveRecord::Migration
  def change
    add_reference :construct_tags, :donor_construct, index: true, foreign_key: true
  end
end
