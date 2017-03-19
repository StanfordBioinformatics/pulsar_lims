class Crispr < ActiveRecord::Base
  belongs_to :user
  belongs_to :crispr_construct
  belongs_to :donor_construct
  belongs_to :biosample
end
