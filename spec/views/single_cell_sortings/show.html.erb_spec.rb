require 'rails_helper'

RSpec.describe "single_cell_sortings/show", type: :view do
  before(:each) do
    @single_cell_sorting = assign(:single_cell_sorting, SingleCellSorting.create!(
      :user => nil,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
