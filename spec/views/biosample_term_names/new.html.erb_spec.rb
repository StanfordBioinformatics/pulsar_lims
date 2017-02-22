require 'rails_helper'

RSpec.describe "biosample_term_names/new", type: :view do
  before(:each) do
    assign(:biosample_term_name, BiosampleTermName.new(
      :user => nil,
      :name => "MyString",
      :accession => "MyString",
      :biosample_ontology => nil,
      :description => "MyText"
    ))
  end

  it "renders new biosample_term_name form" do
    render

    assert_select "form[action=?][method=?]", biosample_term_names_path, "post" do

      assert_select "input#biosample_term_name_user_id[name=?]", "biosample_term_name[user_id]"

      assert_select "input#biosample_term_name_name[name=?]", "biosample_term_name[name]"

      assert_select "input#biosample_term_name_accession[name=?]", "biosample_term_name[accession]"

      assert_select "input#biosample_term_name_biosample_ontology_id[name=?]", "biosample_term_name[biosample_ontology_id]"

      assert_select "textarea#biosample_term_name_description[name=?]", "biosample_term_name[description]"
    end
  end
end
