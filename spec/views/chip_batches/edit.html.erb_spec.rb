require 'rails_helper'

RSpec.describe "chip_batches/edit", type: :view do
  before(:each) do
    @chip_batch = assign(:chip_batch, ChipBatch.create!(
      :user => nil,
      :crosslinking_method => "MyString"
    ))
  end

  it "renders the edit chip_batch form" do
    render

    assert_select "form[action=?][method=?]", chip_batch_path(@chip_batch), "post" do

      assert_select "input#chip_batch_user_id[name=?]", "chip_batch[user_id]"

      assert_select "input#chip_batch_crosslinking_method[name=?]", "chip_batch[crosslinking_method]"
    end
  end
end
