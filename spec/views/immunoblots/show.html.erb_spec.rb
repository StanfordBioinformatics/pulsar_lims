require 'rails_helper'

RSpec.describe "immunoblots/show", type: :view do
  before(:each) do
    @immunoblot = assign(:immunoblot, Immunoblot.create!(
      :user => nil,
      :agarose_gel => nil,
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
