class AddShippingToCrisprConstruct < ActiveRecord::Migration
  def change
    add_reference :crispr_constructs, :sent_to
    add_foreign_key :crispr_constructs, :addresses, column: :sent_to_id
    add_column :crispr_constructs, :date_sent, :date
  end
end
