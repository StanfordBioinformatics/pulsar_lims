class CreateJoinTableConstructTagsCrisprConstructs < ActiveRecord::Migration
  def change
    create_join_table :construct_tags, :crispr_constructs do |t|
      t.integer :construct_tag_id
      t.integer :crispr_construct_id
    end
    add_index :construct_tags_crispr_constructs, [:construct_tag_id, :crispr_construct_id], name: "tag_construct"
    add_index :construct_tags_crispr_constructs, [:crispr_construct_id, :construct_tag_id], name: "construct_tag"
  end
end
