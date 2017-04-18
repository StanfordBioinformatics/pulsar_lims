require 'rails_helper'

RSpec.describe "wells/show", type: :view do
  before(:each) do
    @well = assign(:well, Well.create!(
      :user => nil,
      :name => "Name",
      :plate => nil,
      :row => 2,
      :col => 3,
      :barcode => nil,
      :paired_barcode => nil,
      :fail => false,
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
  end
end
