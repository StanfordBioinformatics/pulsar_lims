require 'rails_helper'

RSpec.describe "single_cell_sortings/new", type: :view do
  before(:each) do
    assign(:single_cell_sorting, SingleCellSorting.new(
      :user => nil,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new single_cell_sorting form" do
    render

    assert_select "form[action=?][method=?]", single_cell_sortings_path, "post" do

      assert_select "input#single_cell_sorting_user_id[name=?]", "single_cell_sorting[user_id]"

      assert_select "input#single_cell_sorting_name[name=?]", "single_cell_sorting[name]"

      assert_select "textarea#single_cell_sorting_description[name=?]", "single_cell_sorting[description]"
    end
  end
end
