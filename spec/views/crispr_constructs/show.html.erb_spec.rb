require 'rails_helper'

RSpec.describe "crispr_constructs/show", type: :view do
  before(:each) do
    @crispr_construct = assign(:crispr_construct, CrisprConstruct.create!(
      :name => "Name",
      :user => nil,
      :target => nil,
      :guide_sequence => "MyText",
      :cloning_vector => nil,
      :description => "MyText",
      :vendor => nil,
      :vendor_product_identifier => "Vendor Product Identifier"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Vendor Product Identifier/)
  end
end
