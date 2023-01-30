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

ActiveRecord::Schema.define(version: 2023_01_19_085125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "demandes", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "status", default: 0
    t.string "commentaire"
    t.integer "nbr_jours"
    t.integer "employe_id"
    t.integer "motif_id"
    t.index ["employe_id"], name: "index_demandes_on_employe_id"
    t.index ["end_date"], name: "index_demandes_on_end_date"
    t.index ["motif_id"], name: "index_demandes_on_motif_id"
    t.index ["start_date"], name: "index_demandes_on_start_date"
  end

  create_table "motifs", force: :cascade do |t|
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.integer "balance", default: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
