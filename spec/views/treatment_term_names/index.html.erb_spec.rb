require 'rails_helper'

RSpec.describe "treatment_term_names/index", type: :view do
  before(:each) do
    assign(:treatment_term_names, [
      TreatmentTermName.create!(
        :user => nil,
        :name => "Name",
        :accession => "Accession",
        :description => "MyText"
      ),
      TreatmentTermName.create!(
        :user => nil,
        :name => "Name",
        :accession => "Accession",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of treatment_term_names" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Accession".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
