require 'rails_helper'

RSpec.describe "primers/new", type: :view do
  before(:each) do
    assign(:primer, Primer.new(
      :user => nil,
      :name => "MyString",
      :description => "MyText",
      :notes => "MyText",
      :direction => "MyString",
      :sequence => "MyString",
      :melting_temperature => "MyString"
    ))
  end

  it "renders new primer form" do
    render

    assert_select "form[action=?][method=?]", primers_path, "post" do

      assert_select "input#primer_user_id[name=?]", "primer[user_id]"

      assert_select "input#primer_name[name=?]", "primer[name]"

      assert_select "textarea#primer_description[name=?]", "primer[description]"

      assert_select "textarea#primer_notes[name=?]", "primer[notes]"

      assert_select "input#primer_direction[name=?]", "primer[direction]"

      assert_select "input#primer_sequence[name=?]", "primer[sequence]"

      assert_select "input#primer_melting_temperature[name=?]", "primer[melting_temperature]"
    end
  end
end
