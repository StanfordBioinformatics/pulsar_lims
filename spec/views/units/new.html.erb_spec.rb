require 'rails_helper'

RSpec.describe "units/new", type: :view do
  before(:each) do
    assign(:unit, Unit.new(
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders new unit form" do
    render

    assert_select "form[action=?][method=?]", units_path, "post" do

      assert_select "input#unit_name[name=?]", "unit[name]"

      assert_select "input#unit_user_id[name=?]", "unit[user_id]"
    end
  end
end
