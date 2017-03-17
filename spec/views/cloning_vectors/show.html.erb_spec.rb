require 'rails_helper'

RSpec.describe "cloning_vectors/show", type: :view do
  before(:each) do
    @cloning_vector = assign(:cloning_vector, CloningVector.create!(
      :user => nil,
      :name => "Name",
      :description => "MyText",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Url/)
  end
end
