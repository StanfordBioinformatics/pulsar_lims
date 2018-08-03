require 'rails_helper'

RSpec.describe "immunoblots/edit", type: :view do
  before(:each) do
    @immunoblot = assign(:immunoblot, Immunoblot.create!(
      :user => nil,
      :agarose_gel => nil,
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders the edit immunoblot form" do
    render

    assert_select "form[action=?][method=?]", immunoblot_path(@immunoblot), "post" do

      assert_select "input#immunoblot_user_id[name=?]", "immunoblot[user_id]"

      assert_select "input#immunoblot_agarose_gel_id[name=?]", "immunoblot[agarose_gel_id]"

      assert_select "textarea#immunoblot_submitter_comments[name=?]", "immunoblot[submitter_comments]"

      assert_select "textarea#immunoblot_notes[name=?]", "immunoblot[notes]"
    end
  end
end
