class Antibody < ActiveRecord::Base
  belongs_to :organism
  belongs_to :antibody_purifications
  belongs_to :vendor
  belongs_to :isotype
  belongs_to :human_gene
end
