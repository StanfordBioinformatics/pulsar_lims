require 'rails_helper'

RSpec.describe "concentration_units/new", type: :view do
  before(:each) do
    assign(:concentration_unit, ConcentrationUnit.new(
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders new concentration_unit form" do
    render

    assert_select "form[action=?][method=?]", concentration_units_path, "post" do

      assert_select "input#concentration_unit_name[name=?]", "concentration_unit[name]"

      assert_select "input#concentration_unit_user_id[name=?]", "concentration_unit[user_id]"
    end
  end
end
