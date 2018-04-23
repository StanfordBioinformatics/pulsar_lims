# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180423215729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "city"
    t.string   "state"
    t.integer  "postal_code"
    t.string   "country"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.string   "street"
    t.string   "name"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "analyses", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "merged_peaks_file_id"
    t.integer  "merged_bam_file_id"
    t.integer  "merged_qc_file_id"
    t.integer  "single_cell_sorting_id"
    t.integer  "protocol_id"
    t.integer  "merged_fastq_file_id"
  end

  add_index "analyses", ["merged_bam_file_id"], name: "index_analyses_on_merged_bam_file_id", using: :btree
  add_index "analyses", ["merged_fastq_file_id"], name: "index_analyses_on_merged_fastq_file_id", using: :btree
  add_index "analyses", ["merged_peaks_file_id"], name: "index_analyses_on_merged_peaks_file_id", using: :btree
  add_index "analyses", ["merged_qc_file_id"], name: "index_analyses_on_merged_qc_file_id", using: :btree
  add_index "analyses", ["protocol_id"], name: "index_analyses_on_protocol_id", using: :btree
  add_index "analyses", ["single_cell_sorting_id"], name: "index_analyses_on_single_cell_sorting_id", using: :btree
  add_index "analyses", ["user_id"], name: "index_analyses_on_user_id", using: :btree

  create_table "antibodies", force: :cascade do |t|
    t.integer  "organism_id"
    t.integer  "vendor_id"
    t.integer  "isotype_id"
    t.string   "vendor_product_identifier", limit: 255
    t.string   "vendor_product_url",        limit: 255
    t.string   "lot_identifier",            limit: 255
    t.string   "clonality",                 limit: 255
    t.string   "antigen_description",       limit: 255
    t.string   "antigen_sequence",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                      limit: 255
    t.integer  "user_id"
    t.integer  "target_id"
    t.string   "upstream_identifier"
  end

  add_index "antibodies", ["isotype_id"], name: "index_antibodies_on_isotype_id", using: :btree
  add_index "antibodies", ["name"], name: "index_antibodies_on_name", unique: true, using: :btree
  add_index "antibodies", ["organism_id"], name: "index_antibodies_on_organism_id", using: :btree
  add_index "antibodies", ["target_id"], name: "index_antibodies_on_target_id", using: :btree
  add_index "antibodies", ["user_id"], name: "index_antibodies_on_user_id", using: :btree
  add_index "antibodies", ["vendor_id"], name: "index_antibodies_on_vendor_id", using: :btree

  create_table "antibodies_antibody_purifications", id: false, force: :cascade do |t|
    t.integer "antibody_id"
    t.integer "antibody_purification_id"
  end

  create_table "antibodies_plates", id: false, force: :cascade do |t|
    t.integer "antibody_id", null: false
    t.integer "plate_id",    null: false
  end

  add_index "antibodies_plates", ["antibody_id", "plate_id"], name: "index_antibodies_plates_on_antibody_id_and_plate_id", using: :btree
  add_index "antibodies_plates", ["plate_id", "antibody_id"], name: "index_antibodies_plates_on_plate_id_and_antibody_id", using: :btree

  create_table "antibody_purifications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "antibody_purifications", ["user_id"], name: "index_antibody_purifications_on_user_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "attachments", ["user_id"], name: "index_attachments_on_user_id", using: :btree

  create_table "barcodes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sequencing_library_prep_kit_id"
    t.string   "name"
    t.string   "sequence"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "index_number"
  end

  add_index "barcodes", ["sequencing_library_prep_kit_id"], name: "index_barcodes_on_sequencing_library_prep_kit_id", using: :btree
  add_index "barcodes", ["user_id"], name: "index_barcodes_on_user_id", using: :btree

  create_table "biosample_ontologies", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "biosample_ontologies", ["name"], name: "index_biosample_ontologies_on_name", unique: true, using: :btree
  add_index "biosample_ontologies", ["url"], name: "index_biosample_ontologies_on_url", unique: true, using: :btree
  add_index "biosample_ontologies", ["user_id"], name: "index_biosample_ontologies_on_user_id", using: :btree

  create_table "biosample_term_names", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "accession"
    t.integer  "biosample_ontology_id"
    t.text     "description"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "biosample_term_names", ["biosample_ontology_id"], name: "index_biosample_term_names_on_biosample_ontology_id", using: :btree
  add_index "biosample_term_names", ["name"], name: "index_biosample_term_names_on_name", unique: true, using: :btree
  add_index "biosample_term_names", ["user_id"], name: "index_biosample_term_names_on_user_id", using: :btree

  create_table "biosample_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "tissue",                 default: false
  end

  add_index "biosample_types", ["user_id"], name: "index_biosample_types_on_user_id", using: :btree

  create_table "biosamples", force: :cascade do |t|
    t.string   "submitter_comments",              limit: 255
    t.string   "lot_identifier",                  limit: 255
    t.string   "vendor_product_identifier",       limit: 255
    t.string   "description",                     limit: 255
    t.integer  "passage_number"
    t.date     "date_biosample_taken"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vendor_id"
    t.integer  "biosample_type_id"
    t.string   "name",                            limit: 255
    t.integer  "donor_id"
    t.integer  "user_id"
    t.integer  "biosample_term_name_id"
    t.boolean  "control"
    t.integer  "part_of_biosample_id"
    t.integer  "well_id"
    t.boolean  "prototype",                                   default: false
    t.integer  "from_prototype_id"
    t.boolean  "plated",                                      default: false
    t.integer  "owner_id"
    t.string   "tissue_preservation_method"
    t.string   "nih_institutional_certification"
    t.string   "upstream_identifier"
    t.string   "starting_amount"
    t.string   "starting_amount_units"
    t.string   "tube_label"
    t.integer  "times_cloned",                                default: 0
  end

  add_index "biosamples", ["biosample_term_name_id"], name: "index_biosamples_on_biosample_term_name_id", using: :btree
  add_index "biosamples", ["biosample_type_id"], name: "index_biosamples_on_biosample_type_id", using: :btree
  add_index "biosamples", ["donor_id"], name: "index_biosamples_on_donor_id", using: :btree
  add_index "biosamples", ["from_prototype_id"], name: "index_biosamples_on_from_prototype_id", using: :btree
  add_index "biosamples", ["name"], name: "index_biosamples_on_name", unique: true, using: :btree
  add_index "biosamples", ["owner_id"], name: "index_biosamples_on_owner_id", using: :btree
  add_index "biosamples", ["part_of_biosample_id"], name: "index_biosamples_on_part_of_biosample_id", using: :btree
  add_index "biosamples", ["user_id"], name: "index_biosamples_on_user_id", using: :btree
  add_index "biosamples", ["vendor_id"], name: "index_biosamples_on_vendor_id", using: :btree
  add_index "biosamples", ["well_id"], name: "index_biosamples_on_well_id", using: :btree

  create_table "biosamples_documents", id: false, force: :cascade do |t|
    t.integer "biosample_id"
    t.integer "document_id"
  end

  create_table "biosamples_pooled_from_biosamples", id: false, force: :cascade do |t|
    t.integer "biosample_id"
    t.integer "pooled_from_biosample_id"
  end

  create_table "biosamples_treatments", id: false, force: :cascade do |t|
    t.integer "biosample_id", null: false
    t.integer "treatment_id", null: false
  end

  add_index "biosamples_treatments", ["biosample_id", "treatment_id"], name: "index_biosamples_treatments_on_biosample_id_and_treatment_id", using: :btree
  add_index "biosamples_treatments", ["treatment_id", "biosample_id"], name: "index_biosamples_treatments_on_treatment_id_and_biosample_id", using: :btree

  create_table "chromosomes", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "reference_genome_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "chromosomes", ["reference_genome_id"], name: "index_chromosomes_on_reference_genome_id", using: :btree
  add_index "chromosomes", ["user_id"], name: "index_chromosomes_on_user_id", using: :btree

  create_table "cloning_vectors", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "product_url"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "vendor_id"
    t.string   "vendor_product_identifier"
    t.string   "map"
  end

  add_index "cloning_vectors", ["name"], name: "index_cloning_vectors_on_name", unique: true, using: :btree
  add_index "cloning_vectors", ["user_id"], name: "index_cloning_vectors_on_user_id", using: :btree
  add_index "cloning_vectors", ["vendor_id"], name: "index_cloning_vectors_on_vendor_id", using: :btree

  create_table "concentration_units", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "concentration_units", ["user_id"], name: "index_concentration_units_on_user_id", using: :btree

  create_table "construct_tags", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "construct_tags", ["name"], name: "index_construct_tags_on_name", unique: true, using: :btree
  add_index "construct_tags", ["user_id"], name: "index_construct_tags_on_user_id", using: :btree

  create_table "construct_tags_crispr_constructs", id: false, force: :cascade do |t|
    t.integer "construct_tag_id"
    t.integer "crispr_construct_id"
  end

  add_index "construct_tags_crispr_constructs", ["construct_tag_id", "crispr_construct_id"], name: "tag_construct", using: :btree
  add_index "construct_tags_crispr_constructs", ["crispr_construct_id", "construct_tag_id"], name: "construct_tag", using: :btree

  create_table "construct_tags_donor_constructs", id: false, force: :cascade do |t|
    t.integer "construct_tag_id",   null: false
    t.integer "donor_construct_id", null: false
  end

  add_index "construct_tags_donor_constructs", ["construct_tag_id"], name: "index_construct_tags_donor_constructs_on_construct_tag_id", using: :btree
  add_index "construct_tags_donor_constructs", ["donor_construct_id"], name: "index_construct_tags_donor_constructs_on_donor_construct_id", using: :btree

  create_table "crispr_constructs", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "target_id"
    t.text     "guide_sequence"
    t.integer  "cloning_vector_id"
    t.text     "description"
    t.integer  "vendor_id"
    t.string   "vendor_product_identifier"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "addgene_id"
    t.string   "ensembl_transcript"
    t.string   "refseq_transcript"
  end

  add_index "crispr_constructs", ["addgene_id"], name: "index_crispr_constructs_on_addgene_id", using: :btree
  add_index "crispr_constructs", ["cloning_vector_id"], name: "index_crispr_constructs_on_cloning_vector_id", using: :btree
  add_index "crispr_constructs", ["name"], name: "index_crispr_constructs_on_name", unique: true, using: :btree
  add_index "crispr_constructs", ["target_id"], name: "index_crispr_constructs_on_target_id", using: :btree
  add_index "crispr_constructs", ["user_id"], name: "index_crispr_constructs_on_user_id", using: :btree
  add_index "crispr_constructs", ["vendor_id"], name: "index_crispr_constructs_on_vendor_id", using: :btree

  create_table "crispr_constructs_modifications", id: false, force: :cascade do |t|
    t.integer "crispr_construct_id",    null: false
    t.integer "crispr_modification_id", null: false
  end

  add_index "crispr_constructs_modifications", ["crispr_construct_id", "crispr_modification_id"], name: "crispr_construct_crispr_mod", using: :btree
  add_index "crispr_constructs_modifications", ["crispr_modification_id", "crispr_construct_id"], name: "crispr_mod_crispr_construct", using: :btree

  create_table "crispr_modifications", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "donor_construct_id"
    t.integer  "biosample_id"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "genomic_integration_site_id"
    t.string   "upstream_identifier"
    t.string   "category"
    t.string   "purpose"
  end

  add_index "crispr_modifications", ["biosample_id"], name: "index_crispr_modifications_on_biosample_id", using: :btree
  add_index "crispr_modifications", ["donor_construct_id"], name: "index_crispr_modifications_on_donor_construct_id", using: :btree
  add_index "crispr_modifications", ["genomic_integration_site_id"], name: "index_crispr_modifications_on_genomic_integration_site_id", using: :btree
  add_index "crispr_modifications", ["name"], name: "index_crispr_modifications_on_name", unique: true, using: :btree
  add_index "crispr_modifications", ["user_id"], name: "index_crispr_modifications_on_user_id", using: :btree

  create_table "data_file_types", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "data_file_types", ["user_id"], name: "index_data_file_types_on_user_id", using: :btree

  create_table "data_storage_providers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "bucket_storage", default: false
  end

  add_index "data_storage_providers", ["user_id"], name: "index_data_storage_providers_on_user_id", using: :btree

  create_table "data_storages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "bucket"
    t.string   "project_identifier"
    t.string   "folder_base_path"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "data_storage_provider_id"
  end

  add_index "data_storages", ["data_storage_provider_id"], name: "index_data_storages_on_data_storage_provider_id", using: :btree
  add_index "data_storages", ["user_id"], name: "index_data_storages_on_user_id", using: :btree

  create_table "document_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "document_types", ["user_id"], name: "index_document_types_on_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "description",         limit: 255
    t.string   "content_type",        limit: 255
    t.binary   "data"
    t.integer  "document_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_protocol"
    t.string   "upstream_identifier"
  end

  add_index "documents", ["document_type_id"], name: "index_documents_on_document_type_id", using: :btree
  add_index "documents", ["name"], name: "index_documents_on_name", unique: true, using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "documents_libraries", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "library_id"
  end

  create_table "documents_sequencing_library_prep_kits", id: false, force: :cascade do |t|
    t.integer "document_id",                    null: false
    t.integer "sequencing_library_prep_kit_id", null: false
  end

  create_table "documents_single_cell_sortings", id: false, force: :cascade do |t|
    t.integer "document_id",            null: false
    t.integer "single_cell_sorting_id", null: false
  end

  add_index "documents_single_cell_sortings", ["document_id", "single_cell_sorting_id"], name: "document_scs_idx", using: :btree
  add_index "documents_single_cell_sortings", ["single_cell_sorting_id", "document_id"], name: "scs_document_idx", using: :btree

  create_table "documents_treatments", id: false, force: :cascade do |t|
    t.integer "document_id",  null: false
    t.integer "treatment_id", null: false
  end

  add_index "documents_treatments", ["document_id", "treatment_id"], name: "index_documents_treatments_on_document_id_and_treatment_id", using: :btree
  add_index "documents_treatments", ["treatment_id", "document_id"], name: "index_documents_treatments_on_treatment_id_and_document_id", using: :btree

  create_table "donor_constructs", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "cloning_vector_id"
    t.integer  "vendor_id"
    t.string   "vendor_product_identifier"
    t.integer  "target_id"
    t.text     "description"
    t.text     "insert_sequence"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "addgene_id"
    t.string   "primer_left_forward"
    t.string   "primer_left_reverse"
    t.string   "primer_right_forward"
    t.string   "primer_right_reverse"
    t.string   "ensembl_transcript"
    t.string   "refseq_transcript"
  end

  add_index "donor_constructs", ["addgene_id"], name: "index_donor_constructs_on_addgene_id", using: :btree
  add_index "donor_constructs", ["cloning_vector_id"], name: "index_donor_constructs_on_cloning_vector_id", using: :btree
  add_index "donor_constructs", ["name"], name: "index_donor_constructs_on_name", unique: true, using: :btree
  add_index "donor_constructs", ["target_id"], name: "index_donor_constructs_on_target_id", using: :btree
  add_index "donor_constructs", ["user_id"], name: "index_donor_constructs_on_user_id", using: :btree
  add_index "donor_constructs", ["vendor_id"], name: "index_donor_constructs_on_vendor_id", using: :btree

  create_table "donors", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "upstream_identifier"
    t.string   "age"
    t.string   "gender"
  end

  add_index "donors", ["user_id"], name: "index_donors_on_user_id", using: :btree

  create_table "experiment_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "experiment_types", ["user_id"], name: "index_experiment_types_on_user_id", using: :btree

  create_table "file_references", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "data_storage_id"
    t.string   "file_path"
    t.string   "fileid"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "data_file_type_id"
  end

  add_index "file_references", ["data_file_type_id"], name: "index_file_references_on_data_file_type_id", using: :btree
  add_index "file_references", ["data_storage_id"], name: "index_file_references_on_data_storage_id", using: :btree
  add_index "file_references", ["user_id"], name: "index_file_references_on_user_id", using: :btree

  create_table "genome_locations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chromosome_id"
    t.integer  "start"
    t.integer  "end"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "genome_locations", ["chromosome_id"], name: "index_genome_locations_on_chromosome_id", using: :btree
  add_index "genome_locations", ["user_id"], name: "index_genome_locations_on_user_id", using: :btree

  create_table "isotypes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "isotypes", ["user_id"], name: "index_isotypes_on_user_id", using: :btree

  create_table "libraries", force: :cascade do |t|
    t.integer  "nucleic_acid_term_id"
    t.integer  "biosample_id"
    t.integer  "vendor_id"
    t.string   "lot_identifier",                  limit: 255
    t.string   "vendor_product_identifier",       limit: 255
    t.string   "size_range",                      limit: 255
    t.boolean  "strand_specific"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                            limit: 255
    t.integer  "user_id"
    t.float    "concentration"
    t.integer  "library_fragmentation_method_id"
    t.integer  "sequencing_library_prep_kit_id"
    t.boolean  "paired_end"
    t.integer  "barcode_id"
    t.integer  "paired_barcode_id"
    t.boolean  "prototype",                                   default: false
    t.integer  "from_prototype_id"
    t.integer  "concentration_unit_id"
    t.boolean  "plated",                                      default: false
    t.string   "upstream_identifier"
  end

  add_index "libraries", ["barcode_id"], name: "index_libraries_on_barcode_id", using: :btree
  add_index "libraries", ["biosample_id"], name: "index_libraries_on_biosample_id", using: :btree
  add_index "libraries", ["concentration_unit_id"], name: "index_libraries_on_concentration_unit_id", using: :btree
  add_index "libraries", ["from_prototype_id"], name: "index_libraries_on_from_prototype_id", using: :btree
  add_index "libraries", ["library_fragmentation_method_id"], name: "index_libraries_on_library_fragmentation_method_id", using: :btree
  add_index "libraries", ["name"], name: "index_libraries_on_name", unique: true, using: :btree
  add_index "libraries", ["nucleic_acid_term_id"], name: "index_libraries_on_nucleic_acid_term_id", using: :btree
  add_index "libraries", ["paired_barcode_id"], name: "index_libraries_on_paired_barcode_id", using: :btree
  add_index "libraries", ["sequencing_library_prep_kit_id"], name: "index_libraries_on_sequencing_library_prep_kit_id", using: :btree
  add_index "libraries", ["user_id"], name: "index_libraries_on_user_id", using: :btree
  add_index "libraries", ["vendor_id"], name: "index_libraries_on_vendor_id", using: :btree

  create_table "libraries_paired_barcodes", id: false, force: :cascade do |t|
    t.integer "library_id"
    t.integer "paired_barcode_id"
  end

  add_index "libraries_paired_barcodes", ["library_id", "paired_barcode_id"], name: "library_paired_barcode", using: :btree
  add_index "libraries_paired_barcodes", ["paired_barcode_id", "library_id"], name: "paired_barcode_library", using: :btree

  create_table "libraries_sequencing_requests", id: false, force: :cascade do |t|
    t.integer "library_id",            null: false
    t.integer "sequencing_request_id", null: false
  end

  add_index "libraries_sequencing_requests", ["library_id", "sequencing_request_id"], name: "lib_sreq_index", unique: true, using: :btree
  add_index "libraries_sequencing_requests", ["library_id"], name: "index_libraries_sequencing_requests_on_library_id", using: :btree
  add_index "libraries_sequencing_requests", ["sequencing_request_id"], name: "index_libraries_sequencing_requests_on_sequencing_request_id", using: :btree

  create_table "library_fragmentation_methods", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "library_fragmentation_methods", ["user_id"], name: "index_library_fragmentation_methods_on_user_id", using: :btree

  create_table "nucleic_acid_terms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "accession",  limit: 255
    t.string   "definition", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "nucleic_acid_terms", ["user_id"], name: "index_nucleic_acid_terms_on_user_id", using: :btree

  create_table "organisms", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "ncbi_taxon"
    t.string   "scientific_name"
  end

  add_index "organisms", ["user_id"], name: "index_organisms_on_user_id", using: :btree

  create_table "paired_barcodes", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "index1_id"
    t.integer  "index2_id"
    t.integer  "sequencing_library_prep_kit_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "paired_barcodes", ["index1_id"], name: "index_paired_barcodes_on_index1_id", using: :btree
  add_index "paired_barcodes", ["index2_id"], name: "index_paired_barcodes_on_index2_id", using: :btree
  add_index "paired_barcodes", ["sequencing_library_prep_kit_id", "index1_id", "index2_id"], name: "kit_index1_index2", unique: true, using: :btree
  add_index "paired_barcodes", ["sequencing_library_prep_kit_id"], name: "index_paired_barcodes_on_sequencing_library_prep_kit_id", using: :btree
  add_index "paired_barcodes", ["user_id"], name: "index_paired_barcodes_on_user_id", using: :btree

  create_table "pcr_master_mixes", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.string   "vendor_product_identifier"
    t.string   "vendor_product_url"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "lot_identifier"
  end

  add_index "pcr_master_mixes", ["user_id"], name: "index_pcr_master_mixes_on_user_id", using: :btree
  add_index "pcr_master_mixes", ["vendor_id"], name: "index_pcr_master_mixes_on_vendor_id", using: :btree

  create_table "pcrs", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "description"
    t.integer  "pcr_master_mix_id"
    t.string   "forward_primer"
    t.string   "reverse_primer"
    t.integer  "amplicon_size"
    t.float    "annealing_temperature"
    t.integer  "extension_time"
    t.integer  "num_cycles"
    t.integer  "crispr_modification_id"
    t.boolean  "success"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "pcrs", ["crispr_modification_id"], name: "index_pcrs_on_crispr_modification_id", using: :btree
  add_index "pcrs", ["pcr_master_mix_id"], name: "index_pcrs_on_pcr_master_mix_id", using: :btree
  add_index "pcrs", ["user_id"], name: "index_pcrs_on_user_id", using: :btree

  create_table "plates", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "vendor_id"
    t.string   "vendor_product_identifier"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "dimensions"
    t.integer  "single_cell_sorting_id"
  end

  add_index "plates", ["single_cell_sorting_id"], name: "index_plates_on_single_cell_sorting_id", using: :btree
  add_index "plates", ["user_id"], name: "index_plates_on_user_id", using: :btree
  add_index "plates", ["vendor_id"], name: "index_plates_on_vendor_id", using: :btree

  create_table "plates_sequencing_requests", id: false, force: :cascade do |t|
    t.integer "plate_id",              null: false
    t.integer "sequencing_request_id", null: false
  end

  add_index "plates_sequencing_requests", ["plate_id", "sequencing_request_id"], name: "plate_sequencing_request", using: :btree
  add_index "plates_sequencing_requests", ["sequencing_request_id", "plate_id"], name: "sequencing_request_plate", using: :btree

  create_table "reference_genomes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "reference_genomes", ["user_id"], name: "index_reference_genomes_on_user_id", using: :btree

  create_table "sequencing_centers", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "url"
  end

  add_index "sequencing_centers", ["user_id"], name: "index_sequencing_centers_on_user_id", using: :btree

  create_table "sequencing_library_prep_kits", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "vendor_id"
    t.text     "description"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "vendor_product_identifier"
    t.boolean  "supports_paired_end"
  end

  add_index "sequencing_library_prep_kits", ["user_id"], name: "index_sequencing_library_prep_kits_on_user_id", using: :btree
  add_index "sequencing_library_prep_kits", ["vendor_id", "name"], name: "index_sequencing_library_prep_kits_on_vendor_id_and_name", unique: true, using: :btree
  add_index "sequencing_library_prep_kits", ["vendor_id"], name: "index_sequencing_library_prep_kits_on_vendor_id", using: :btree

  create_table "sequencing_platforms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "sequencing_platforms", ["user_id"], name: "index_sequencing_platforms_on_user_id", using: :btree

  create_table "sequencing_requests", force: :cascade do |t|
    t.string   "name"
    t.text     "comment"
    t.integer  "sequencing_platform_id"
    t.integer  "sequencing_center_id"
    t.boolean  "shipped"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.boolean  "paired_end"
    t.integer  "concentration_unit_id"
    t.float    "concentration"
    t.string   "sample_sheet"
  end

  add_index "sequencing_requests", ["concentration_unit_id"], name: "index_sequencing_requests_on_concentration_unit_id", using: :btree
  add_index "sequencing_requests", ["name"], name: "index_sequencing_requests_on_name", unique: true, using: :btree
  add_index "sequencing_requests", ["sequencing_center_id"], name: "index_sequencing_requests_on_sequencing_center_id", using: :btree
  add_index "sequencing_requests", ["sequencing_platform_id"], name: "index_sequencing_requests_on_sequencing_platform_id", using: :btree
  add_index "sequencing_requests", ["user_id"], name: "index_sequencing_requests_on_user_id", using: :btree

  create_table "sequencing_results", force: :cascade do |t|
    t.integer  "library_id"
    t.text     "comment"
    t.string   "read1_uri"
    t.string   "read2_uri"
    t.integer  "read1_count"
    t.integer  "read2_count"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.integer  "sequencing_run_id"
  end

  add_index "sequencing_results", ["library_id"], name: "index_sequencing_results_on_library_id", using: :btree
  add_index "sequencing_results", ["sequencing_run_id"], name: "index_sequencing_results_on_sequencing_run_id", using: :btree
  add_index "sequencing_results", ["user_id"], name: "index_sequencing_results_on_user_id", using: :btree

  create_table "sequencing_runs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sequencing_request_id"
    t.integer  "report_id"
    t.integer  "lane"
    t.text     "comment"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "name"
    t.integer  "storage_location_id"
  end

  add_index "sequencing_runs", ["name"], name: "index_sequencing_runs_on_name", unique: true, using: :btree
  add_index "sequencing_runs", ["report_id"], name: "index_sequencing_runs_on_report_id", using: :btree
  add_index "sequencing_runs", ["sequencing_request_id"], name: "index_sequencing_runs_on_sequencing_request_id", using: :btree
  add_index "sequencing_runs", ["storage_location_id"], name: "index_sequencing_runs_on_storage_location_id", using: :btree
  add_index "sequencing_runs", ["user_id"], name: "index_sequencing_runs_on_user_id", using: :btree

  create_table "single_cell_sortings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "sorting_biosample_id"
    t.integer  "starting_biosample_id"
    t.integer  "library_prototype_id"
    t.string   "fluorescence_intensity_file"
    t.string   "upstream_identifier"
  end

  add_index "single_cell_sortings", ["library_prototype_id"], name: "index_single_cell_sortings_on_library_prototype_id", using: :btree
  add_index "single_cell_sortings", ["sorting_biosample_id"], name: "index_single_cell_sortings_on_sorting_biosample_id", using: :btree
  add_index "single_cell_sortings", ["starting_biosample_id"], name: "index_single_cell_sortings_on_starting_biosample_id", using: :btree
  add_index "single_cell_sortings", ["user_id"], name: "index_single_cell_sortings_on_user_id", using: :btree

  create_table "targets", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "ensembl"
    t.string   "refseq"
    t.string   "upstream_identifier"
    t.string   "uniprotkb"
  end

  add_index "targets", ["name"], name: "index_targets_on_name", unique: true, using: :btree
  add_index "targets", ["user_id"], name: "index_targets_on_user_id", using: :btree

  create_table "treatment_term_names", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "accession"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "treatment_term_names", ["user_id"], name: "index_treatment_term_names_on_user_id", using: :btree

  create_table "treatments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "treatment_term_name_id"
    t.string   "name"
    t.text     "description"
    t.string   "treatment_type"
    t.float    "concentration"
    t.integer  "concentration_unit_id"
    t.float    "duration"
    t.string   "duration_units"
    t.float    "temperature"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "upstream_identifier"
  end

  add_index "treatments", ["concentration_unit_id"], name: "index_treatments_on_concentration_unit_id", using: :btree
  add_index "treatments", ["treatment_term_name_id"], name: "index_treatments_on_treatment_term_name_id", using: :btree
  add_index "treatments", ["user_id"], name: "index_treatments_on_user_id", using: :btree

  create_table "uberons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "accession",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "uberons", ["user_id"], name: "index_uberons_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived_at"
    t.integer  "role",                   default: 1
    t.string   "api_key"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["api_key"], name: "index_users_on_api_key", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "description",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url",                 limit: 255
    t.integer  "user_id"
    t.string   "upstream_identifier"
  end

  add_index "vendors", ["name"], name: "index_vendors_on_name", unique: true, using: :btree
  add_index "vendors", ["user_id"], name: "index_vendors_on_user_id", using: :btree

  create_table "wells", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "plate_id"
    t.integer  "row"
    t.integer  "col"
    t.boolean  "fail",       default: false
    t.text     "comment"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "wells", ["col"], name: "index_wells_on_col", using: :btree
  add_index "wells", ["plate_id"], name: "index_wells_on_plate_id", using: :btree
  add_index "wells", ["row"], name: "index_wells_on_row", using: :btree
  add_index "wells", ["user_id"], name: "index_wells_on_user_id", using: :btree

  add_foreign_key "addresses", "users"
  add_foreign_key "analyses", "documents", column: "protocol_id"
  add_foreign_key "analyses", "file_references", column: "merged_bam_file_id"
  add_foreign_key "analyses", "file_references", column: "merged_fastq_file_id"
  add_foreign_key "analyses", "file_references", column: "merged_peaks_file_id"
  add_foreign_key "analyses", "file_references", column: "merged_qc_file_id"
  add_foreign_key "analyses", "single_cell_sortings"
  add_foreign_key "analyses", "users"
  add_foreign_key "antibodies", "isotypes"
  add_foreign_key "antibodies", "organisms"
  add_foreign_key "antibodies", "targets"
  add_foreign_key "antibodies", "users"
  add_foreign_key "antibodies", "vendors"
  add_foreign_key "antibody_purifications", "users"
  add_foreign_key "attachments", "users"
  add_foreign_key "barcodes", "sequencing_library_prep_kits"
  add_foreign_key "barcodes", "users"
  add_foreign_key "biosample_ontologies", "users"
  add_foreign_key "biosample_term_names", "biosample_ontologies"
  add_foreign_key "biosample_term_names", "users"
  add_foreign_key "biosample_types", "users"
  add_foreign_key "biosamples", "biosample_term_names"
  add_foreign_key "biosamples", "biosample_types"
  add_foreign_key "biosamples", "biosamples", column: "from_prototype_id"
  add_foreign_key "biosamples", "biosamples", column: "part_of_biosample_id"
  add_foreign_key "biosamples", "donors"
  add_foreign_key "biosamples", "users"
  add_foreign_key "biosamples", "users", column: "owner_id"
  add_foreign_key "biosamples", "vendors"
  add_foreign_key "biosamples", "wells"
  add_foreign_key "chromosomes", "reference_genomes"
  add_foreign_key "chromosomes", "users"
  add_foreign_key "cloning_vectors", "users"
  add_foreign_key "cloning_vectors", "vendors"
  add_foreign_key "concentration_units", "users"
  add_foreign_key "construct_tags", "users"
  add_foreign_key "crispr_constructs", "cloning_vectors"
  add_foreign_key "crispr_constructs", "targets"
  add_foreign_key "crispr_constructs", "users"
  add_foreign_key "crispr_constructs", "vendors"
  add_foreign_key "crispr_modifications", "biosamples"
  add_foreign_key "crispr_modifications", "donor_constructs"
  add_foreign_key "crispr_modifications", "genome_locations", column: "genomic_integration_site_id"
  add_foreign_key "crispr_modifications", "users"
  add_foreign_key "data_file_types", "users"
  add_foreign_key "data_storage_providers", "users"
  add_foreign_key "data_storages", "data_storage_providers"
  add_foreign_key "data_storages", "users"
  add_foreign_key "document_types", "users"
  add_foreign_key "documents", "document_types"
  add_foreign_key "documents", "users"
  add_foreign_key "donor_constructs", "cloning_vectors"
  add_foreign_key "donor_constructs", "targets"
  add_foreign_key "donor_constructs", "users"
  add_foreign_key "donor_constructs", "vendors"
  add_foreign_key "donors", "users"
  add_foreign_key "experiment_types", "users"
  add_foreign_key "file_references", "data_file_types"
  add_foreign_key "file_references", "data_storages"
  add_foreign_key "file_references", "users"
  add_foreign_key "genome_locations", "chromosomes"
  add_foreign_key "genome_locations", "users"
  add_foreign_key "isotypes", "users"
  add_foreign_key "libraries", "barcodes"
  add_foreign_key "libraries", "biosamples"
  add_foreign_key "libraries", "concentration_units"
  add_foreign_key "libraries", "libraries", column: "from_prototype_id"
  add_foreign_key "libraries", "library_fragmentation_methods"
  add_foreign_key "libraries", "nucleic_acid_terms"
  add_foreign_key "libraries", "paired_barcodes"
  add_foreign_key "libraries", "sequencing_library_prep_kits"
  add_foreign_key "libraries", "users"
  add_foreign_key "libraries", "vendors"
  add_foreign_key "library_fragmentation_methods", "users"
  add_foreign_key "nucleic_acid_terms", "users"
  add_foreign_key "organisms", "users"
  add_foreign_key "paired_barcodes", "barcodes", column: "index1_id"
  add_foreign_key "paired_barcodes", "barcodes", column: "index2_id"
  add_foreign_key "paired_barcodes", "sequencing_library_prep_kits"
  add_foreign_key "paired_barcodes", "users"
  add_foreign_key "pcr_master_mixes", "users"
  add_foreign_key "pcr_master_mixes", "vendors"
  add_foreign_key "pcrs", "crispr_modifications"
  add_foreign_key "pcrs", "pcr_master_mixes"
  add_foreign_key "pcrs", "users"
  add_foreign_key "plates", "single_cell_sortings"
  add_foreign_key "plates", "users"
  add_foreign_key "plates", "vendors"
  add_foreign_key "reference_genomes", "users"
  add_foreign_key "sequencing_centers", "users"
  add_foreign_key "sequencing_library_prep_kits", "users"
  add_foreign_key "sequencing_library_prep_kits", "vendors"
  add_foreign_key "sequencing_platforms", "users"
  add_foreign_key "sequencing_requests", "concentration_units"
  add_foreign_key "sequencing_requests", "sequencing_centers"
  add_foreign_key "sequencing_requests", "sequencing_platforms"
  add_foreign_key "sequencing_requests", "users"
  add_foreign_key "sequencing_results", "libraries"
  add_foreign_key "sequencing_results", "sequencing_runs"
  add_foreign_key "sequencing_results", "users"
  add_foreign_key "sequencing_runs", "documents", column: "report_id"
  add_foreign_key "sequencing_runs", "file_references", column: "storage_location_id"
  add_foreign_key "sequencing_runs", "sequencing_requests"
  add_foreign_key "sequencing_runs", "users"
  add_foreign_key "single_cell_sortings", "biosamples", column: "sorting_biosample_id"
  add_foreign_key "single_cell_sortings", "biosamples", column: "starting_biosample_id"
  add_foreign_key "single_cell_sortings", "libraries", column: "library_prototype_id"
  add_foreign_key "single_cell_sortings", "users"
  add_foreign_key "targets", "users"
  add_foreign_key "treatment_term_names", "users"
  add_foreign_key "treatments", "concentration_units"
  add_foreign_key "treatments", "treatment_term_names"
  add_foreign_key "treatments", "users"
  add_foreign_key "uberons", "users"
  add_foreign_key "vendors", "users"
  add_foreign_key "wells", "plates"
  add_foreign_key "wells", "users"
end
