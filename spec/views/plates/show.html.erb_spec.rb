require 'rails_helper'

RSpec.describe "plates/show", type: :view do
  before(:each) do
    @plate = assign(:plate, Plate.create!(
      :user => nil,
      :name => "Name",
      :sequencing_library_prep_kit => nil,
      :paired_end => false,
      :num_rows => 2,
      :num_cols => 3,
      :vendor => nil,
      :vendor_product_identifier => "Vendor Product Identifier"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Vendor Product Identifier/)
  end
end
