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

ActiveRecord::Schema.define(version: 2023_01_16_140126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "demandes", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "status"
    t.string "commentaire"
    t.integer "employe_id"
    t.integer "motif_id"
    t.index ["employe_id", "motif_id"], name: "index_demandes_on_employe_id_and_motif_id", unique: true
    t.index ["employe_id"], name: "index_demandes_on_employe_id"
    t.index ["end_date"], name: "index_demandes_on_end_date"
    t.index ["motif_id"], name: "index_demandes_on_motif_id"
    t.index ["start_date", "end_date"], name: "index_demandes_on_start_date_and_end_date", unique: true
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
  end

end
