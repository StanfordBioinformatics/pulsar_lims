require 'rails_helper'

RSpec.describe "gel_images/show", type: :view do
  before(:each) do
    @gel_image = assign(:gel_image, GelImage.create!(
      :user => nil,
      :gel => nil,
      :film_exposure_time => 2,
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Image/)
  end
end
