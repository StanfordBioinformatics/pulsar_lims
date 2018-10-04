require 'rails_helper'

RSpec.describe "chip_batch_items/edit", type: :view do
  before(:each) do
    @chip_batch_item = assign(:chip_batch_item, ChipBatchItem.create!(
      :user => nil,
      :chip_batch => nil,
      :biosample => nil,
      :concentration => "MyString",
      :notes => "MyText"
    ))
  end

  it "renders the edit chip_batch_item form" do
    render

    assert_select "form[action=?][method=?]", chip_batch_item_path(@chip_batch_item), "post" do

      assert_select "input#chip_batch_item_user_id[name=?]", "chip_batch_item[user_id]"

      assert_select "input#chip_batch_item_chip_batch_id[name=?]", "chip_batch_item[chip_batch_id]"

      assert_select "input#chip_batch_item_biosample_id[name=?]", "chip_batch_item[biosample_id]"

      assert_select "input#chip_batch_item_concentration[name=?]", "chip_batch_item[concentration]"

      assert_select "textarea#chip_batch_item_notes[name=?]", "chip_batch_item[notes]"
    end
  end
end
