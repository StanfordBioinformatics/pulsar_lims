require 'rails_helper'

RSpec.describe "chromosomes/edit", type: :view do
  before(:each) do
    @chromosome = assign(:chromosome, Chromosome.create!(
      :name => "MyString",
      :user => nil,
      :reference_genome => nil
    ))
  end

  it "renders the edit chromosome form" do
    render

    assert_select "form[action=?][method=?]", chromosome_path(@chromosome), "post" do

      assert_select "input#chromosome_name[name=?]", "chromosome[name]"

      assert_select "input#chromosome_user_id[name=?]", "chromosome[user_id]"

      assert_select "input#chromosome_reference_genome_id[name=?]", "chromosome[reference_genome_id]"
    end
  end
end
