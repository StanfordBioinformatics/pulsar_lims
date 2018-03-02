require 'rails_helper'

RSpec.describe "treatments/index", type: :view do
  before(:each) do
    assign(:treatments, [
      Treatment.create!(
        :user => nil,
        :treatment_term_name => nil,
        :name => "Name",
        :description => "MyText",
        :treatment_type => "Treatment Type",
        :concentration => 2.5,
        :concentration_unit => nil,
        :duration => 3.5,
        :duration_units => "Duration Units",
        :temperature => 4.5
      ),
      Treatment.create!(
        :user => nil,
        :treatment_term_name => nil,
        :name => "Name",
        :description => "MyText",
        :treatment_type => "Treatment Type",
        :concentration => 2.5,
        :concentration_unit => nil,
        :duration => 3.5,
        :duration_units => "Duration Units",
        :temperature => 4.5
      )
    ])
  end

  it "renders a list of treatments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Treatment Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "Duration Units".to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
  end
end
