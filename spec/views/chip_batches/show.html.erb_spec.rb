require 'rails_helper'

RSpec.describe "chip_batches/show", type: :view do
  before(:each) do
    @chip_batch = assign(:chip_batch, ChipBatch.create!(
      :user => nil,
      :crosslinking_method => "Crosslinking Method"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Crosslinking Method/)
  end
end
