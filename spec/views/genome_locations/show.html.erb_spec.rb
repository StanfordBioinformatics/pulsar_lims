require 'rails_helper'

RSpec.describe "genome_locations/show", type: :view do
  before(:each) do
    @genome_location = assign(:genome_location, GenomeLocation.create!(
      :name => "Name",
      :user => nil,
      :chromosome => nil,
      :start => 2,
      :end => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
