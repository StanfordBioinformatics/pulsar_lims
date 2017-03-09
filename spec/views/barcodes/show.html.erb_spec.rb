require 'rails_helper'

RSpec.describe "barcodes/show", type: :view do
  before(:each) do
    @barcode = assign(:barcode, Barcode.create!(
      :user => nil,
      :sequencing_library_prep_kit => nil,
      :name => "Name",
      :sequence => "Sequence"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Sequence/)
  end
end
