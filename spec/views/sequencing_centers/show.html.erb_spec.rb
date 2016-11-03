require 'rails_helper'

RSpec.describe "sequencing_centers/show", type: :view do
  before(:each) do
    @sequencing_center = assign(:sequencing_center, SequencingCenter.create!(
      :name => "Name",
      :address => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
