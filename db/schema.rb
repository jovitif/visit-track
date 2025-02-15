# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_15_204423) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "setores_funcionarios", id: false, force: :cascade do |t|
    t.bigint "setor_id", null: false
    t.bigint "user_id", null: false
    t.index ["setor_id"], name: "index_setores_funcionarios_on_setor_id"
    t.index ["user_id"], name: "index_setores_funcionarios_on_user_id"
  end

  create_table "setors", force: :cascade do |t|
    t.string "nome", null: false
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unidade_id"
    t.index ["unidade_id"], name: "index_setors_on_unidade_id"
  end

  create_table "setors_unidades", id: false, force: :cascade do |t|
    t.bigint "unidade_id", null: false
    t.bigint "setor_id", null: false
    t.index ["setor_id"], name: "index_setors_unidades_on_setor_id"
    t.index ["unidade_id"], name: "index_setors_unidades_on_unidade_id"
  end

  create_table "unidades", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 1
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome", null: false
    t.string "cpf", null: false
    t.string "telefone"
    t.bigint "unidade_id"
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unidade_id"], name: "index_users_on_unidade_id"
  end

  create_table "visita", force: :cascade do |t|
    t.integer "idfuncionario"
    t.integer "idvisitante"
    t.string "foto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmado"
  end

  add_foreign_key "setores_funcionarios", "setors"
  add_foreign_key "setores_funcionarios", "users"
  add_foreign_key "setors", "unidades"
  add_foreign_key "users", "unidades"
end
