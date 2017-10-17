require 'rails_helper'

RSpec.describe "analyses/show", type: :view do
  before(:each) do
    @analysis = assign(:analysis, Analysis.create!(
      :user => nil,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
