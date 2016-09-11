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

ActiveRecord::Schema.define(version: 20160911200639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "antibodies", force: true do |t|
    t.integer  "organism_id"
    t.integer  "vendor_id"
    t.integer  "isotype_id"
    t.integer  "human_gene_id"
    t.string   "vendor_product_identifier"
    t.string   "vendor_product_url"
    t.string   "lot_identifier"
    t.string   "clonality"
    t.string   "antigen_description"
    t.string   "antigen_sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "antibodies", ["human_gene_id"], name: "index_antibodies_on_human_gene_id", using: :btree
  add_index "antibodies", ["isotype_id"], name: "index_antibodies_on_isotype_id", using: :btree
  add_index "antibodies", ["name"], name: "index_antibodies_on_name", unique: true, using: :btree
  add_index "antibodies", ["organism_id"], name: "index_antibodies_on_organism_id", using: :btree
  add_index "antibodies", ["vendor_id"], name: "index_antibodies_on_vendor_id", using: :btree

  create_table "antibodies_antibody_purifications", id: false, force: true do |t|
    t.integer "antibody_id"
    t.integer "antibody_purification_id"
  end

  create_table "antibody_purifications", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "biosample_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "biosamples", force: true do |t|
    t.string   "submitter_comments"
    t.string   "lot_identifier"
    t.string   "vendor_product_identifier"
    t.string   "ontology_term_name"
    t.string   "ontology_term_accession"
    t.string   "description"
    t.integer  "passage_number"
    t.date     "culture_harvest_date"
    t.string   "encid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vendor_id"
    t.integer  "biosample_type_id"
    t.string   "name"
    t.integer  "donor_id"
  end

  add_index "biosamples", ["biosample_type_id"], name: "index_biosamples_on_biosample_type_id", using: :btree
  add_index "biosamples", ["donor_id"], name: "index_biosamples_on_donor_id", using: :btree
  add_index "biosamples", ["name"], name: "index_biosamples_on_name", unique: true, using: :btree
  add_index "biosamples", ["vendor_id"], name: "index_biosamples_on_vendor_id", using: :btree

  create_table "biosamples_documents", id: false, force: true do |t|
    t.integer "biosample_id"
    t.integer "document_id"
  end

  create_table "document_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "content_type"
    t.binary   "data"
    t.integer  "document_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["document_type_id"], name: "index_documents_on_document_type_id", using: :btree
  add_index "documents", ["name"], name: "index_documents_on_name", unique: true, using: :btree

  create_table "documents_libraries", id: false, force: true do |t|
    t.integer "document_id"
    t.integer "library_id"
  end

  create_table "donors", force: true do |t|
    t.string   "encode_identifier"
    t.string   "encode_alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiment_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "human_genes", force: true do |t|
    t.string   "encode_identifier"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "isotypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libraries", force: true do |t|
    t.integer  "sequence_ontology_term_id"
    t.integer  "biosample_id"
    t.integer  "antibody_id"
    t.integer  "vendor_id"
    t.string   "lot_identifier"
    t.string   "vendor_product_identifier"
    t.string   "size_range"
    t.boolean  "strand_specific"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "libraries", ["antibody_id"], name: "index_libraries_on_antibody_id", using: :btree
  add_index "libraries", ["biosample_id"], name: "index_libraries_on_biosample_id", using: :btree
  add_index "libraries", ["name"], name: "index_libraries_on_name", unique: true, using: :btree
  add_index "libraries", ["sequence_ontology_term_id"], name: "index_libraries_on_sequence_ontology_term_id", using: :btree
  add_index "libraries", ["vendor_id"], name: "index_libraries_on_vendor_id", using: :btree

  create_table "organisms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reference_genomes", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequence_ontology_terms", force: true do |t|
    t.string   "name"
    t.string   "accession"
    t.string   "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequencing_platforms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uberons", force: true do |t|
    t.string   "name"
    t.string   "accession"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vendors", ["name"], name: "index_vendors_on_name", unique: true, using: :btree

end
