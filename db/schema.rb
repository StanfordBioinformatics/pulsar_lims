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

ActiveRecord::Schema.define(version: 20160830051832) do

  create_table "antibodies", force: true do |t|
    t.integer  "organism_id"
    t.integer  "antibody_purifications_id"
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
  end

  add_index "antibodies", ["antibody_purifications_id"], name: "index_antibodies_on_antibody_purifications_id"
  add_index "antibodies", ["human_gene_id"], name: "index_antibodies_on_human_gene_id"
  add_index "antibodies", ["isotype_id"], name: "index_antibodies_on_isotype_id"
  add_index "antibodies", ["organism_id"], name: "index_antibodies_on_organism_id"
  add_index "antibodies", ["vendor_id"], name: "index_antibodies_on_vendor_id"

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
    t.string   "term_name"
    t.string   "term_identifier"
    t.string   "description"
    t.integer  "passage_number"
    t.date     "culture_harvest_date"
    t.string   "encid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "human_donor_id"
    t.integer  "vendor_id"
    t.integer  "biosample_type_id"
  end

  add_index "biosamples", ["biosample_type_id"], name: "index_biosamples_on_biosample_type_id"
  add_index "biosamples", ["human_donor_id"], name: "index_biosamples_on_human_donor_id"
  add_index "biosamples", ["vendor_id"], name: "index_biosamples_on_vendor_id"

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
    t.integer  "biosample_id"
  end

  add_index "documents", ["biosample_id"], name: "index_documents_on_biosample_id"
  add_index "documents", ["document_type_id"], name: "index_documents_on_document_type_id"

  create_table "human_donors", force: true do |t|
    t.string   "encode_identifier"
    t.string   "encode_alias"
    t.string   "string"
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

  create_table "organisms", force: true do |t|
    t.string   "name"
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

end
