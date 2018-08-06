require 'rails_helper'

RSpec.describe "agarose_gels/index", type: :view do
  before(:each) do
    assign(:agarose_gels, [
      AgaroseGel.create!(
        :percent_agarose => "Percent Agarose",
        :voltage => "Voltage",
        :notes => "MyText",
        :user => nil
      ),
      AgaroseGel.create!(
        :percent_agarose => "Percent Agarose",
        :voltage => "Voltage",
        :notes => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of agarose_gels" do
    render
    assert_select "tr>td", :text => "Percent Agarose".to_s, :count => 2
    assert_select "tr>td", :text => "Voltage".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
