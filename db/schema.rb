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

ActiveRecord::Schema.define(version: 20170227050829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

  add_index "biosample_types", ["user_id"], name: "index_biosample_types_on_user_id", using: :btree

  create_table "biosamples", force: :cascade do |t|
    t.string   "submitter_comments",        limit: 255
    t.string   "lot_identifier",            limit: 255
    t.string   "vendor_product_identifier", limit: 255
    t.string   "description",               limit: 255
    t.integer  "passage_number"
    t.date     "culture_harvest_date"
    t.string   "encid",                     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vendor_id"
    t.integer  "biosample_type_id"
    t.string   "name",                      limit: 255
    t.integer  "donor_id"
    t.integer  "user_id"
    t.integer  "biosample_term_name_id"
  end

  add_index "biosamples", ["biosample_term_name_id"], name: "index_biosamples_on_biosample_term_name_id", using: :btree
  add_index "biosamples", ["biosample_type_id"], name: "index_biosamples_on_biosample_type_id", using: :btree
  add_index "biosamples", ["donor_id"], name: "index_biosamples_on_donor_id", using: :btree
  add_index "biosamples", ["name"], name: "index_biosamples_on_name", unique: true, using: :btree
  add_index "biosamples", ["user_id"], name: "index_biosamples_on_user_id", using: :btree
  add_index "biosamples", ["vendor_id"], name: "index_biosamples_on_vendor_id", using: :btree

  create_table "biosamples_documents", id: false, force: :cascade do |t|
    t.integer "biosample_id"
    t.integer "document_id"
  end

  create_table "crispr_genetic_modifications", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.string   "vendor_product_identifier"
    t.text     "guide_rna_sequences"
    t.string   "insert_sequence"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "crispr_genetic_modifications", ["user_id"], name: "index_crispr_genetic_modifications_on_user_id", using: :btree
  add_index "crispr_genetic_modifications", ["vendor_id"], name: "index_crispr_genetic_modifications_on_vendor_id", using: :btree

  create_table "document_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "document_types", ["user_id"], name: "index_document_types_on_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "description",      limit: 255
    t.string   "content_type",     limit: 255
    t.binary   "data"
    t.integer  "document_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_protocol"
  end

  add_index "documents", ["document_type_id"], name: "index_documents_on_document_type_id", using: :btree
  add_index "documents", ["name"], name: "index_documents_on_name", unique: true, using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "documents_libraries", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "library_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string   "encode_identifier", limit: 255
    t.string   "name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "donors", ["user_id"], name: "index_donors_on_user_id", using: :btree

  create_table "experiment_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "experiment_types", ["user_id"], name: "index_experiment_types_on_user_id", using: :btree

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
    t.string   "lot_identifier",            limit: 255
    t.string   "vendor_product_identifier", limit: 255
    t.string   "size_range",                limit: 255
    t.boolean  "strand_specific"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                      limit: 255
    t.integer  "user_id"
    t.integer  "antibody_id"
    t.string   "barcode"
  end

  add_index "libraries", ["biosample_id"], name: "index_libraries_on_biosample_id", using: :btree
  add_index "libraries", ["name"], name: "index_libraries_on_name", unique: true, using: :btree
  add_index "libraries", ["nucleic_acid_term_id"], name: "index_libraries_on_nucleic_acid_term_id", using: :btree
  add_index "libraries", ["user_id"], name: "index_libraries_on_user_id", using: :btree
  add_index "libraries", ["vendor_id"], name: "index_libraries_on_vendor_id", using: :btree

  create_table "libraries_sequencing_requests", id: false, force: :cascade do |t|
    t.integer "library_id",            null: false
    t.integer "sequencing_request_id", null: false
  end

  add_index "libraries_sequencing_requests", ["library_id"], name: "index_libraries_sequencing_requests_on_library_id", using: :btree
  add_index "libraries_sequencing_requests", ["sequencing_request_id"], name: "index_libraries_sequencing_requests_on_sequencing_request_id", using: :btree

  create_table "library_sequencing_results", force: :cascade do |t|
    t.string   "name"
    t.integer  "sequencing_result_id"
    t.integer  "library_id"
    t.text     "comment"
    t.string   "read1_uri"
    t.string   "read2_uri"
    t.integer  "read1_count"
    t.integer  "read2_count"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id"
  end

  add_index "library_sequencing_results", ["library_id"], name: "index_library_sequencing_results_on_library_id", using: :btree
  add_index "library_sequencing_results", ["name"], name: "index_library_sequencing_results_on_name", unique: true, using: :btree
  add_index "library_sequencing_results", ["sequencing_result_id"], name: "index_library_sequencing_results_on_sequencing_result_id", using: :btree
  add_index "library_sequencing_results", ["user_id"], name: "index_library_sequencing_results_on_user_id", using: :btree

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
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "organisms", ["user_id"], name: "index_organisms_on_user_id", using: :btree

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
  end

  add_index "sequencing_centers", ["user_id"], name: "index_sequencing_centers_on_user_id", using: :btree

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
  end

  add_index "sequencing_requests", ["name"], name: "index_sequencing_requests_on_name", unique: true, using: :btree
  add_index "sequencing_requests", ["sequencing_center_id"], name: "index_sequencing_requests_on_sequencing_center_id", using: :btree
  add_index "sequencing_requests", ["sequencing_platform_id"], name: "index_sequencing_requests_on_sequencing_platform_id", using: :btree
  add_index "sequencing_requests", ["user_id"], name: "index_sequencing_requests_on_user_id", using: :btree

  create_table "sequencing_results", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sequencing_request_id"
    t.integer  "report_id"
    t.string   "run_name"
    t.integer  "lane"
    t.text     "comment"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "name"
  end

  add_index "sequencing_results", ["name"], name: "index_sequencing_results_on_name", unique: true, using: :btree
  add_index "sequencing_results", ["report_id"], name: "index_sequencing_results_on_report_id", using: :btree
  add_index "sequencing_results", ["sequencing_request_id"], name: "index_sequencing_results_on_sequencing_request_id", using: :btree
  add_index "sequencing_results", ["user_id"], name: "index_sequencing_results_on_user_id", using: :btree

  create_table "targets", force: :cascade do |t|
    t.string   "encode_identifier", limit: 255
    t.string   "name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "targets", ["encode_identifier"], name: "index_targets_on_encode_identifier", unique: true, using: :btree
  add_index "targets", ["name"], name: "index_targets_on_name", unique: true, using: :btree
  add_index "targets", ["user_id"], name: "index_targets_on_user_id", using: :btree

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "description",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url",               limit: 255
    t.integer  "user_id"
    t.string   "encode_identifier"
  end

  add_index "vendors", ["encode_identifier"], name: "index_vendors_on_encode_identifier", unique: true, using: :btree
  add_index "vendors", ["name"], name: "index_vendors_on_name", unique: true, using: :btree
  add_index "vendors", ["user_id"], name: "index_vendors_on_user_id", using: :btree

  add_foreign_key "antibodies", "isotypes"
  add_foreign_key "antibodies", "organisms"
  add_foreign_key "antibodies", "targets"
  add_foreign_key "antibodies", "users"
  add_foreign_key "antibodies", "vendors"
  add_foreign_key "antibody_purifications", "users"
  add_foreign_key "attachments", "users"
  add_foreign_key "biosample_ontologies", "users"
  add_foreign_key "biosample_term_names", "biosample_ontologies"
  add_foreign_key "biosample_term_names", "users"
  add_foreign_key "biosample_types", "users"
  add_foreign_key "biosamples", "biosample_term_names"
  add_foreign_key "biosamples", "biosample_types"
  add_foreign_key "biosamples", "donors"
  add_foreign_key "biosamples", "users"
  add_foreign_key "biosamples", "vendors"
  add_foreign_key "crispr_genetic_modifications", "users"
  add_foreign_key "crispr_genetic_modifications", "vendors"
  add_foreign_key "document_types", "users"
  add_foreign_key "documents", "document_types"
  add_foreign_key "documents", "users"
  add_foreign_key "donors", "users"
  add_foreign_key "experiment_types", "users"
  add_foreign_key "isotypes", "users"
  add_foreign_key "libraries", "biosamples"
  add_foreign_key "libraries", "nucleic_acid_terms"
  add_foreign_key "libraries", "users"
  add_foreign_key "libraries", "vendors"
  add_foreign_key "library_sequencing_results", "libraries"
  add_foreign_key "library_sequencing_results", "sequencing_results"
  add_foreign_key "library_sequencing_results", "users"
  add_foreign_key "nucleic_acid_terms", "users"
  add_foreign_key "organisms", "users"
  add_foreign_key "reference_genomes", "users"
  add_foreign_key "sequencing_centers", "users"
  add_foreign_key "sequencing_platforms", "users"
  add_foreign_key "sequencing_requests", "sequencing_centers"
  add_foreign_key "sequencing_requests", "sequencing_platforms"
  add_foreign_key "sequencing_requests", "users"
  add_foreign_key "sequencing_results", "documents", column: "report_id"
  add_foreign_key "sequencing_results", "sequencing_requests"
  add_foreign_key "sequencing_results", "users"
  add_foreign_key "targets", "users"
  add_foreign_key "uberons", "users"
  add_foreign_key "vendors", "users"
end
