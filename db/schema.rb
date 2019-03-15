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

ActiveRecord::Schema.define(version: 2019_02_28_143045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.integer "phone_number"
    t.integer "mobile_number"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "status"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cufe"
    t.string "tipo_documento"
    t.string "documento_relacionado"
    t.string "razon_social"
    t.integer "ruc"
    t.string "direccion_del_emisor"
    t.string "cliente"
    t.string "ruc_cedula_cliente"
    t.string "direccion_cliente"
    t.integer "numero_factura"
    t.integer "serie"
    t.date "fecha_de_emision"
    t.float "suma"
    t.float "descuento"
    t.float "valor_pago"
    t.string "forma_de_pago"
    t.float "vuelto"
    t.bigint "protocolo_de_autorizacion"
    t.datetime "fecha_de_protocolo"
    t.json "items"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "phone_number"
    t.string "mobile_number"
  end

end
