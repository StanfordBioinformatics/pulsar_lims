require 'rails_helper'

RSpec.describe "crisprs/show", type: :view do
  before(:each) do
    @crispr = assign(:crispr, Crispr.create!(
      :name => "Name",
      :user => nil,
      :crispr_construct => nil,
      :donor_construct => nil,
      :biosample => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
