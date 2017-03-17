require 'rails_helper'

RSpec.describe "construct_tags/show", type: :view do
  before(:each) do
    @construct_tag = assign(:construct_tag, ConstructTag.create!(
      :user => nil,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
