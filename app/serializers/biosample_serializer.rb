class BiosampleSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
             :cells_died_after_transfection,
             :cells_discarded,
             :control,
             :crispr_modification_id,
             :date_biosample_taken,
             :description,
             :lot_identifier,
             :name,
             :notes,
             :nih_institutional_certification,
             :part_of_id,
             :passage_number,
             :replicate_number,
             :starting_amount,
             :starting_amount_units,
             :submitter_comments,
             :times_cloned,
             :tissue_preservation_method,
             :transfection_date,
             :tube_label,
             :user_id,
             :vendor_product_identifier,
             :wild_type,
             :upstream_identifier,
             :created_at,
             :updated_at

  has_one :batch_item
  has_one :biosample_term_name
  has_one :biosample_type
  has_one :donor
  has_one :sorting_biosample_single_cell_sorting
  has_one :transfected_by
  has_one :vendor
  has_many :chipseq_experiments
  has_many :documents
  has_many :immunoblots
  has_many :libraries
  has_many :biosample_parts
  has_many :pooled_biosamples
  has_many :pooled_from_biosamples
  has_many :shippings
  has_many :treatments
  has_many :wt_for_chipseq_experiments

end
