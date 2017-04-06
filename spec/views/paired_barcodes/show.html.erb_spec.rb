require 'rails_helper'

RSpec.describe "paired_barcodes/show", type: :view do
  before(:each) do
    @paired_barcode = assign(:paired_barcode, PairedBarcode.create!(
      :name => "Name",
      :user => nil,
      :index1 => nil,
      :index2 => nil,
      :sequencing_library_prep_kit => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
