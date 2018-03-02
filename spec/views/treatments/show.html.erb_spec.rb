require 'rails_helper'

RSpec.describe "treatments/show", type: :view do
  before(:each) do
    @treatment = assign(:treatment, Treatment.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Treatment Type/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Duration Units/)
    expect(rendered).to match(/4.5/)
  end
end
