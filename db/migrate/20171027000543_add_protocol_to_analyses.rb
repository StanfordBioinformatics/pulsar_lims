class AddProtocolToAnalyses < ActiveRecord::Migration
  def change
    add_reference :analyses, :protocol, index: true
		add_foreign_key :analyses, :documents, column: :protocol_id
  end
end
