require 'rails_helper'

RSpec.describe "biosample_term_names/index", type: :view do
  before(:each) do
    assign(:biosample_term_names, [
      BiosampleTermName.create!(
        :user => nil,
        :name => "Name",
        :accession => "Accession",
        :biosample_ontology => nil,
        :description => "MyText"
      ),
      BiosampleTermName.create!(
        :user => nil,
        :name => "Name",
        :accession => "Accession",
        :biosample_ontology => nil,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of biosample_term_names" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Accession".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
