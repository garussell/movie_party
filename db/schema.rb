# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_906_183_737) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password_digest'
    t.integer 'role', default: 0
  end

  create_table 'users_watch_parties', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'watch_party_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_users_watch_parties_on_user_id'
    t.index ['watch_party_id'], name: 'index_users_watch_parties_on_watch_party_id'
  end

  create_table 'watch_parties', force: :cascade do |t|
    t.string 'host'
    t.string 'movie'
    t.integer 'duration'
    t.date 'date'
    t.datetime 'time'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_ids', array: true
  end
end
