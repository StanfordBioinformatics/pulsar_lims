require 'rails_helper'

RSpec.describe "single_cell_sortings/edit", type: :view do
  before(:each) do
    @single_cell_sorting = assign(:single_cell_sorting, SingleCellSorting.create!(
      :user => nil,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit single_cell_sorting form" do
    render

    assert_select "form[action=?][method=?]", single_cell_sorting_path(@single_cell_sorting), "post" do

      assert_select "input#single_cell_sorting_user_id[name=?]", "single_cell_sorting[user_id]"

      assert_select "input#single_cell_sorting_name[name=?]", "single_cell_sorting[name]"

      assert_select "textarea#single_cell_sorting_description[name=?]", "single_cell_sorting[description]"
    end
  end
end
