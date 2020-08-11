class AntibodySerializer < ActiveModel::Serializer
  self.root = false
  
  attributes :id,
        :antigen_description, :antigen_sequence,
        :clonality,
        :concentration, 
        :concentration_units_id,
        :isotype_id,
        :lot_identifier,
        :name,
        :notes,
        :organism_id,
        :target_id,
        :upstream_identifier,
        :vendor_id,
        :vendor_product_identifier,
        :vendor_product_url
#        antibody_purifications_attributes: [
#          :id,
#          :_destroy
#        ]

  #has_many :antibody_purifications_attributes
end
