require 'rails_helper'

RSpec.describe "treatment_term_names/show", type: :view do
  before(:each) do
    @treatment_term_name = assign(:treatment_term_name, TreatmentTermName.create!(
      :user => nil,
      :name => "Name",
      :accession => "Accession",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Accession/)
    expect(rendered).to match(/MyText/)
  end
end
