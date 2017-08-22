require 'rails_helper'

RSpec.describe "concentration_units/edit", type: :view do
  before(:each) do
    @concentration_unit = assign(:concentration_unit, ConcentrationUnit.create!(
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders the edit concentration_unit form" do
    render

    assert_select "form[action=?][method=?]", concentration_unit_path(@concentration_unit), "post" do

      assert_select "input#concentration_unit_name[name=?]", "concentration_unit[name]"

      assert_select "input#concentration_unit_user_id[name=?]", "concentration_unit[user_id]"
    end
  end
end
