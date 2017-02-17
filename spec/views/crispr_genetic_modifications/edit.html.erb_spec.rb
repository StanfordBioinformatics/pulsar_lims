require 'rails_helper'

RSpec.describe "crispr_genetic_modifications/edit", type: :view do
  before(:each) do
    @crispr_genetic_modification = assign(:crispr_genetic_modification, CrisprGeneticModification.create!(
      :name => "MyString",
      :user => nil,
      :vendor => nil,
      :vendor_product_identifier => "MyString",
      :guide_rna_sequences => "MyText",
      :insert_sequence => "MyString"
    ))
  end

  it "renders the edit crispr_genetic_modification form" do
    render

    assert_select "form[action=?][method=?]", crispr_genetic_modification_path(@crispr_genetic_modification), "post" do

      assert_select "input#crispr_genetic_modification_name[name=?]", "crispr_genetic_modification[name]"

      assert_select "input#crispr_genetic_modification_user_id[name=?]", "crispr_genetic_modification[user_id]"

      assert_select "input#crispr_genetic_modification_vendor_id[name=?]", "crispr_genetic_modification[vendor_id]"

      assert_select "input#crispr_genetic_modification_vendor_product_identifier[name=?]", "crispr_genetic_modification[vendor_product_identifier]"

      assert_select "textarea#crispr_genetic_modification_guide_rna_sequences[name=?]", "crispr_genetic_modification[guide_rna_sequences]"

      assert_select "input#crispr_genetic_modification_insert_sequence[name=?]", "crispr_genetic_modification[insert_sequence]"
    end
  end
end
