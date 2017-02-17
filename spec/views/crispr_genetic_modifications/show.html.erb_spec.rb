require 'rails_helper'

RSpec.describe "crispr_genetic_modifications/show", type: :view do
  before(:each) do
    @crispr_genetic_modification = assign(:crispr_genetic_modification, CrisprGeneticModification.create!(
      :name => "Name",
      :user => nil,
      :vendor => nil,
      :vendor_product_identifier => "Vendor Product Identifier",
      :guide_rna_sequences => "MyText",
      :insert_sequence => "Insert Sequence"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Vendor Product Identifier/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Insert Sequence/)
  end
end
