require 'rails_helper'

RSpec.describe "treatments/new", type: :view do
  before(:each) do
    assign(:treatment, Treatment.new(
      :user => nil,
      :treatment_term_name => nil,
      :name => "MyString",
      :description => "MyText",
      :treatment_type => "MyString",
      :concentration => 1.5,
      :concentration_unit => nil,
      :duration => 1.5,
      :duration_units => "MyString",
      :temperature => 1.5
    ))
  end

  it "renders new treatment form" do
    render

    assert_select "form[action=?][method=?]", treatments_path, "post" do

      assert_select "input#treatment_user_id[name=?]", "treatment[user_id]"

      assert_select "input#treatment_treatment_term_name_id[name=?]", "treatment[treatment_term_name_id]"

      assert_select "input#treatment_name[name=?]", "treatment[name]"

      assert_select "textarea#treatment_description[name=?]", "treatment[description]"

      assert_select "input#treatment_treatment_type[name=?]", "treatment[treatment_type]"

      assert_select "input#treatment_concentration[name=?]", "treatment[concentration]"

      assert_select "input#treatment_concentration_unit_id[name=?]", "treatment[concentration_unit_id]"

      assert_select "input#treatment_duration[name=?]", "treatment[duration]"

      assert_select "input#treatment_duration_units[name=?]", "treatment[duration_units]"

      assert_select "input#treatment_temperature[name=?]", "treatment[temperature]"
    end
  end
end
