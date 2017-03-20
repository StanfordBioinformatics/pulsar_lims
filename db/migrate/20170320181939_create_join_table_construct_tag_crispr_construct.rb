class CreateJoinTableConstructTagCrisprConstruct < ActiveRecord::Migration
  def change
    create_join_table :construct_tags, :crispr_tags do |t|
      t.index :construct_tag_id
      t.index :crispr_tag_id
    end
  end
end
