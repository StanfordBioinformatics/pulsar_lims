require 'rails_helper'

RSpec.describe "agarose_gels/new", type: :view do
  before(:each) do
    assign(:agarose_gel, AgaroseGel.new(
      :percent_agarose => "MyString",
      :voltage => "MyString",
      :notes => "MyText",
      :user => nil
    ))
  end

  it "renders new agarose_gel form" do
    render

    assert_select "form[action=?][method=?]", agarose_gels_path, "post" do

      assert_select "input#agarose_gel_percent_agarose[name=?]", "agarose_gel[percent_agarose]"

      assert_select "input#agarose_gel_voltage[name=?]", "agarose_gel[voltage]"

      assert_select "textarea#agarose_gel_notes[name=?]", "agarose_gel[notes]"

      assert_select "input#agarose_gel_user_id[name=?]", "agarose_gel[user_id]"
    end
  end
end
