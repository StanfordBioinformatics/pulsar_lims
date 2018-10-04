require 'rails_helper'

RSpec.describe "chip_batch_items/show", type: :view do
  before(:each) do
    @chip_batch_item = assign(:chip_batch_item, ChipBatchItem.create!(
      :user => nil,
      :chip_batch => nil,
      :biosample => nil,
      :concentration => "Concentration",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Concentration/)
    expect(rendered).to match(/MyText/)
  end
end
