require 'rails_helper'

RSpec.describe "chip_batches/index", type: :view do
  before(:each) do
    assign(:chip_batches, [
      ChipBatch.create!(
        :user => nil,
        :crosslinking_method => "Crosslinking Method"
      ),
      ChipBatch.create!(
        :user => nil,
        :crosslinking_method => "Crosslinking Method"
      )
    ])
  end

  it "renders a list of chip_batches" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Crosslinking Method".to_s, :count => 2
  end
end
