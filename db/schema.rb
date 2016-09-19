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

ActiveRecord::Schema.define(version: 20160919050724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "antibodies", force: :cascade do |t|
    t.integer  "organism_id"
    t.integer  "vendor_id"
    t.integer  "isotype_id"
    t.integer  "human_gene_id"
    t.string   "vendor_product_identifier", limit: 255
    t.string   "vendor_product_url",        limit: 255
    t.string   "lot_identifier",            limit: 255
    t.string   "clonality",                 limit: 255
    t.string   "antigen_description",       limit: 255
    t.string   "antigen_sequence",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                      limit: 255
  end

  add_index "antibodies", ["human_gene_id"], name: "index_antibodies_on_human_gene_id", using: :btree
  add_index "antibodies", ["isotype_id"], name: "index_antibodies_on_isotype_id", using: :btree
  add_index "antibodies", ["name"], name: "index_antibodies_on_name", unique: true, using: :btree
  add_index "antibodies", ["organism_id"], name: "index_antibodies_on_organism_id", using: :btree
  add_index "antibodies", ["vendor_id"], name: "index_antibodies_on_vendor_id", using: :btree

  create_table "antibodies_antibody_purifications", id: false, force: :cascade do |t|
    t.integer "antibody_id"
    t.integer "antibody_purification_id"
  end

  create_table "antibody_purifications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "biosample_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "biosamples", force: :cascade do |t|
    t.string   "submitter_comments",        limit: 255
    t.string   "lot_identifier",            limit: 255
    t.string   "vendor_product_identifier", limit: 255
    t.string   "ontology_term_name",        limit: 255
    t.string   "ontology_term_accession",   limit: 255
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
  end

  add_index "biosamples", ["biosample_type_id"], name: "index_biosamples_on_biosample_type_id", using: :btree
  add_index "biosamples", ["donor_id"], name: "index_biosamples_on_donor_id", using: :btree
  add_index "biosamples", ["name"], name: "index_biosamples_on_name", unique: true, using: :btree
  add_index "biosamples", ["vendor_id"], name: "index_biosamples_on_vendor_id", using: :btree

  create_table "biosamples_documents", id: false, force: :cascade do |t|
    t.integer "biosample_id"
    t.integer "document_id"
  end

  create_table "document_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "description",      limit: 255
    t.string   "content_type",     limit: 255
    t.binary   "data"
    t.integer  "document_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["document_type_id"], name: "index_documents_on_document_type_id", using: :btree
  add_index "documents", ["name"], name: "index_documents_on_name", unique: true, using: :btree

  create_table "documents_libraries", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "library_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string   "encode_identifier", limit: 255
    t.string   "encode_alias",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiment_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "human_genes", force: :cascade do |t|
    t.string   "encode_identifier", limit: 255
    t.string   "name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "isotypes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libraries", force: :cascade do |t|
    t.integer  "nucleic_acid_term_id"
    t.integer  "biosample_id"
    t.integer  "antibody_id"
    t.integer  "vendor_id"
    t.string   "lot_identifier",            limit: 255
    t.string   "vendor_product_identifier", limit: 255
    t.string   "size_range",                limit: 255
    t.boolean  "strand_specific"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                      limit: 255
  end

  add_index "libraries", ["antibody_id"], name: "index_libraries_on_antibody_id", using: :btree
  add_index "libraries", ["biosample_id"], name: "index_libraries_on_biosample_id", using: :btree
  add_index "libraries", ["name"], name: "index_libraries_on_name", unique: true, using: :btree
  add_index "libraries", ["nucleic_acid_term_id"], name: "index_libraries_on_nucleic_acid_term_id", using: :btree
  add_index "libraries", ["vendor_id"], name: "index_libraries_on_vendor_id", using: :btree

  create_table "nucleic_acid_terms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "accession",  limit: 255
    t.string   "definition", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reference_genomes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequencing_platforms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uberons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "accession",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "vendors", ["name"], name: "index_vendors_on_name", unique: true, using: :btree

  add_foreign_key "antibodies", "human_genes"
  add_foreign_key "antibodies", "isotypes"
  add_foreign_key "antibodies", "organisms"
  add_foreign_key "antibodies", "vendors"
  add_foreign_key "biosamples", "biosample_types"
  add_foreign_key "biosamples", "donors"
  add_foreign_key "biosamples", "vendors"
  add_foreign_key "documents", "document_types"
  add_foreign_key "libraries", "antibodies"
  add_foreign_key "libraries", "biosamples"
  add_foreign_key "libraries", "nucleic_acid_terms"
  add_foreign_key "libraries", "vendors"
end
