require 'rails_helper'

RSpec.describe "primers/show", type: :view do
  before(:each) do
    @primer = assign(:primer, Primer.create!(
      :user => nil,
      :name => "Name",
      :description => "MyText",
      :notes => "MyText",
      :direction => "Direction",
      :sequence => "Sequence",
      :melting_temperature => "Melting Temperature"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Direction/)
    expect(rendered).to match(/Sequence/)
    expect(rendered).to match(/Melting Temperature/)
  end
end
