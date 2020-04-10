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

ActiveRecord::Schema.define(version: 20200408090520) do

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "proper_title"
    t.integer "price"
    t.string "author"
    t.string "image"
    t.text "memo"
    t.text "summary"
    t.text "purchase_url"
    t.boolean "favorite"
    t.boolean "own"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "tag_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tag_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_tag_relations_on_book_id"
    t.index ["tag_id", "book_id"], name: "index_tag_relations_on_tag_id_and_book_id", unique: true
    t.index ["tag_id"], name: "index_tag_relations_on_tag_id"
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tag_title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deleted_at"
    t.index ["user_id", "created_at"], name: "index_tags_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.text "introduce_comment"
    t.string "avatar"
    t.string "flash"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "video_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_video_relations_on_book_id"
    t.index ["video_id", "book_id"], name: "index_video_relations_on_video_id_and_book_id", unique: true
    t.index ["video_id"], name: "index_video_relations_on_video_id"
  end

  create_table "videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "video_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_videos_on_book_id"
  end

  add_foreign_key "books", "users"
  add_foreign_key "tags", "users"
  add_foreign_key "videos", "books"
end
