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

ActiveRecord::Schema.define(version: 20160821224017) do

  create_table "biosample_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  add_index "documents", ["document_type_id"], name: "index_documents_on_document_type_id"

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

end
