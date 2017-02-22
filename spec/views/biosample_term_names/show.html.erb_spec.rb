require 'rails_helper'

RSpec.describe "biosample_term_names/show", type: :view do
  before(:each) do
    @biosample_term_name = assign(:biosample_term_name, BiosampleTermName.create!(
      :user => nil,
      :name => "Name",
      :accession => "Accession",
      :biosample_ontology => nil,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Accession/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
