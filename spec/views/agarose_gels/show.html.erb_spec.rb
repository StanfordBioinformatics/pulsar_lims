require 'rails_helper'

RSpec.describe "agarose_gels/show", type: :view do
  before(:each) do
    @agarose_gel = assign(:agarose_gel, AgaroseGel.create!(
      :percent_agarose => "Percent Agarose",
      :voltage => "Voltage",
      :notes => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Percent Agarose/)
    expect(rendered).to match(/Voltage/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
