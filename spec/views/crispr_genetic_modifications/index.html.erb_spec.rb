require 'rails_helper'

RSpec.describe "crispr_genetic_modifications/index", type: :view do
  before(:each) do
    assign(:crispr_genetic_modifications, [
      CrisprGeneticModification.create!(
        :name => "Name",
        :user => nil,
        :vendor => nil,
        :vendor_product_identifier => "Vendor Product Identifier",
        :guide_rna_sequences => "MyText",
        :insert_sequence => "Insert Sequence"
      ),
      CrisprGeneticModification.create!(
        :name => "Name",
        :user => nil,
        :vendor => nil,
        :vendor_product_identifier => "Vendor Product Identifier",
        :guide_rna_sequences => "MyText",
        :insert_sequence => "Insert Sequence"
      )
    ])
  end

  it "renders a list of crispr_genetic_modifications" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Vendor Product Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Insert Sequence".to_s, :count => 2
  end
end
