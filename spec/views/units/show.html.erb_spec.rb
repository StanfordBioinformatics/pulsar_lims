require 'rails_helper'

RSpec.describe "units/show", type: :view do
  before(:each) do
    @unit = assign(:unit, Unit.create!(
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
