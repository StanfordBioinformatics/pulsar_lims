require 'rails_helper'

RSpec.describe "gel_images/edit", type: :view do
  before(:each) do
    @gel_image = assign(:gel_image, GelImage.create!(
      :user => nil,
      :gel => nil,
      :film_exposure_time => 1,
      :image => "MyString"
    ))
  end

  it "renders the edit gel_image form" do
    render

    assert_select "form[action=?][method=?]", gel_image_path(@gel_image), "post" do

      assert_select "input#gel_image_user_id[name=?]", "gel_image[user_id]"

      assert_select "input#gel_image_gel_id[name=?]", "gel_image[gel_id]"

      assert_select "input#gel_image_film_exposure_time[name=?]", "gel_image[film_exposure_time]"

      assert_select "input#gel_image_image[name=?]", "gel_image[image]"
    end
  end
end
