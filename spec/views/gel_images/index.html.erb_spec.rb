require 'rails_helper'

RSpec.describe "gel_images/index", type: :view do
  before(:each) do
    assign(:gel_images, [
      GelImage.create!(
        :user => nil,
        :gel => nil,
        :film_exposure_time => 2,
        :image => "Image"
      ),
      GelImage.create!(
        :user => nil,
        :gel => nil,
        :film_exposure_time => 2,
        :image => "Image"
      )
    ])
  end

  it "renders a list of gel_images" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
