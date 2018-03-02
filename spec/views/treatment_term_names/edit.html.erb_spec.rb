require 'rails_helper'

RSpec.describe "treatment_term_names/edit", type: :view do
  before(:each) do
    @treatment_term_name = assign(:treatment_term_name, TreatmentTermName.create!(
      :user => nil,
      :name => "MyString",
      :accession => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit treatment_term_name form" do
    render

    assert_select "form[action=?][method=?]", treatment_term_name_path(@treatment_term_name), "post" do

      assert_select "input#treatment_term_name_user_id[name=?]", "treatment_term_name[user_id]"

      assert_select "input#treatment_term_name_name[name=?]", "treatment_term_name[name]"

      assert_select "input#treatment_term_name_accession[name=?]", "treatment_term_name[accession]"

      assert_select "textarea#treatment_term_name_description[name=?]", "treatment_term_name[description]"
    end
  end
end
