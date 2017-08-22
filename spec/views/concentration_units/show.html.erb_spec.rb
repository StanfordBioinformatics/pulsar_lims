require 'rails_helper'

RSpec.describe "concentration_units/show", type: :view do
  before(:each) do
    @concentration_unit = assign(:concentration_unit, ConcentrationUnit.create!(
      :name => "Name",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
