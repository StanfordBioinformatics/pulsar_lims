require 'rails_helper'

RSpec.describe "treatment_term_names/new", type: :view do
  before(:each) do
    assign(:treatment_term_name, TreatmentTermName.new(
      :user => nil,
      :name => "MyString",
      :accession => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new treatment_term_name form" do
    render

    assert_select "form[action=?][method=?]", treatment_term_names_path, "post" do

      assert_select "input#treatment_term_name_user_id[name=?]", "treatment_term_name[user_id]"

      assert_select "input#treatment_term_name_name[name=?]", "treatment_term_name[name]"

      assert_select "input#treatment_term_name_accession[name=?]", "treatment_term_name[accession]"

      assert_select "textarea#treatment_term_name_description[name=?]", "treatment_term_name[description]"
    end
  end
end
