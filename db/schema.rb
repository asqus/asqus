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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130602185621) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",                  :null => false
    t.string   "provider",   :limit => 64, :null => false
    t.string   "uid",        :limit => 64, :null => false
    t.text     "token",                    :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "authentications", ["token"], :name => "authentications_token_idx"
  add_index "authentications", ["uid"], :name => "authentications_uid_idx"
  add_index "authentications", ["user_id"], :name => "authentications_user_id_idx"

  create_table "census_national_place_import", :id => false, :force => true do |t|
    t.text    "state_abbreviation"
    t.integer "state_id"
    t.integer "place_id"
    t.text    "place_name"
    t.text    "place_type"
    t.string  "status",             :limit => 1
    t.text    "county"
  end

  create_table "congressional_districts", :id => false, :force => true do |t|
    t.integer  "state_id",   :null => false
    t.integer  "district",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "congressional_districts", ["state_id", "district"], :name => "congressional_districts_uidx", :unique => true

  create_table "counties", :id => false, :force => true do |t|
    t.integer  "state_id",                 :null => false
    t.integer  "ansi_code",                :null => false
    t.string   "name",       :limit => 32, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "counties", ["state_id", "name"], :name => "counties_uidx", :unique => true

  create_table "graph_types", :force => true do |t|
    t.string "name", :limit => 32, :null => false
  end

  add_index "graph_types", ["name"], :name => "graph_type_name_uidx", :unique => true

  create_table "imported_open_states_legislators", :id => false, :force => true do |t|
    t.text     "leg_id"
    t.text     "full_name"
    t.text     "first_name"
    t.text     "middle_name"
    t.text     "last_name"
    t.text     "suffixes"
    t.text     "nickname"
    t.boolean  "active"
    t.text     "state"
    t.text     "chamber"
    t.text     "district"
    t.text     "party"
    t.text     "transparencydata_id"
    t.text     "photo_url"
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
  end

  create_table "issues", :force => true do |t|
    t.string   "title",       :limit => 64, :null => false
    t.text     "comment"
    t.text     "poller_type",               :null => false
    t.integer  "poller_id",                 :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "issues", ["poller_type", "poller_id", "title"], :name => "issues_uidx", :unique => true

  create_table "joined_official_terms", :id => false, :force => true do |t|
    t.integer "official_term_id"
    t.integer "office_id"
    t.integer "official_id"
    t.integer "term_id"
    t.integer "office_type_id"
    t.integer "party_id"
    t.string  "office_discriminator",          :limit => 32
    t.date    "from_date"
    t.date    "to_date"
    t.string  "office_type_ukey",              :limit => 20
    t.string  "office_type_name",              :limit => 32
    t.string  "office_type_title",             :limit => 20
    t.string  "office_type_abbreviated_title", :limit => 20
    t.string  "party_name",                    :limit => 32
    t.string  "party_member_noun",             :limit => 32
    t.string  "party_abbreviation",            :limit => 6
    t.string  "official_first_name",           :limit => 20
    t.string  "official_middle_name",          :limit => 20
    t.string  "official_last_name",            :limit => 20
    t.string  "official_nickname",             :limit => 20
    t.string  "official_name_suffix",          :limit => 20
    t.date    "official_birth_date"
    t.string  "official_gender",               :limit => 1
    t.string  "official_congress_office",      :limit => 256
    t.string  "official_phone",                :limit => 20
    t.string  "official_website",              :limit => 256
    t.string  "official_webform",              :limit => 256
    t.string  "official_twitter_id",           :limit => 64
    t.string  "official_congresspedia_url",    :limit => 256
    t.string  "official_youtube_url",          :limit => 256
    t.string  "official_facebook_id",          :limit => 64
    t.string  "official_fax",                  :limit => 20
    t.integer "official_votesmart_id"
    t.integer "official_govtrack_id"
    t.string  "official_bioguide_id",          :limit => 32
    t.string  "official_eventful_id",          :limit => 64
    t.string  "official_photo_extension",      :limit => 20
    t.string  "official_rss",                  :limit => 256
    t.string  "official_open_states_leg_id",   :limit => 20
    t.string  "official_external_photo_url"
    t.string  "official_transparencydata_id",  :limit => 32
    t.integer "state_id"
    t.text    "state_name"
    t.string  "state_abbreviation",            :limit => 2
    t.integer "us_senate_class"
    t.integer "congressional_district_no"
    t.string  "state_house_district_key",      :limit => 64
    t.string  "state_senate_district_key",     :limit => 64
    t.string  "county_name",                   :limit => 32
    t.integer "county_ansi_code"
    t.string  "municipality_name",             :limit => 32
    t.integer "municipality_ansi_code"
    t.string  "ward",                          :limit => 32
    t.boolean "dirty"
  end

  add_index "joined_official_terms", ["office_id"], :name => "joined_official_terms_office_idx"
  add_index "joined_official_terms", ["office_type_id"], :name => "joined_official_terms_office_type_idx"
  add_index "joined_official_terms", ["official_id"], :name => "joined_official_terms_official_idx"
  add_index "joined_official_terms", ["official_term_id"], :name => "joined_official_terms_uidx"
  add_index "joined_official_terms", ["state_id", "county_ansi_code"], :name => "joined_official_terms_county_idx"
  add_index "joined_official_terms", ["state_id", "municipality_ansi_code"], :name => "joined_official_terms_municipality_idx"
  add_index "joined_official_terms", ["term_id"], :name => "joined_official_terms_term_idx"

  create_table "municipalities", :id => false, :force => true do |t|
    t.integer  "state_id",                 :null => false
    t.integer  "ansi_code",                :null => false
    t.string   "name",       :limit => 32, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "municipalities", ["ansi_code"], :name => "municipalities_ansi_uidx", :unique => true

  create_table "nations", :id => false, :force => true do |t|
    t.integer "id",   :null => false
    t.text    "name", :null => false
  end

  create_table "office_types", :force => true do |t|
    t.string   "ukey",              :limit => 20, :null => false
    t.string   "name",              :limit => 32, :null => false
    t.string   "title",             :limit => 20, :null => false
    t.string   "abbreviated_title", :limit => 20, :null => false
    t.integer  "polity_type_id",                  :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "office_types", ["id", "polity_type_id"], :name => "office_types_polity_type_uidx", :unique => true
  add_index "office_types", ["ukey"], :name => "office_types_uidx", :unique => true

  create_table "offices", :force => true do |t|
    t.integer  "office_type_id",                                           :null => false
    t.integer  "state_id"
    t.integer  "us_senate_class"
    t.integer  "congressional_district_no"
    t.integer  "county_ansi_code"
    t.integer  "municipality_ansi_code"
    t.string   "state_senate_district_key", :limit => 64
    t.string   "state_house_district_key",  :limit => 64
    t.string   "ward",                      :limit => 32
    t.string   "discriminator",             :limit => 32, :default => "0", :null => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  add_index "offices", ["state_id", "congressional_district_no"], :name => "offices_congress_uidx", :unique => true
  add_index "offices", ["state_id", "state_house_district_key", "discriminator"], :name => "offices_state_house_uidx", :unique => true
  add_index "offices", ["state_id", "state_senate_district_key", "discriminator"], :name => "offices_state_senate_uidx", :unique => true
  add_index "offices", ["state_id", "us_senate_class"], :name => "offices_us_senate_uidx", :unique => true

  create_table "official_terms", :force => true do |t|
    t.integer  "official_id", :null => false
    t.integer  "office_id",   :null => false
    t.integer  "term_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "official_terms", ["office_id"], :name => "official_terms_office_idx"
  add_index "official_terms", ["official_id"], :name => "official_terms_official_idx"
  add_index "official_terms", ["term_id"], :name => "official_terms_term_idx"

  create_table "officials", :force => true do |t|
    t.string   "first_name",          :limit => 20,  :null => false
    t.string   "middle_name",         :limit => 20
    t.string   "last_name",           :limit => 20,  :null => false
    t.string   "nickname",            :limit => 20
    t.string   "name_suffix",         :limit => 20
    t.date     "birth_date"
    t.string   "gender",              :limit => 1
    t.integer  "party_id"
    t.string   "congress_office",     :limit => 256
    t.string   "phone",               :limit => 20
    t.string   "email",               :limit => 256
    t.string   "website",             :limit => 256
    t.string   "webform",             :limit => 256
    t.string   "twitter_id",          :limit => 64
    t.string   "congresspedia_url",   :limit => 256
    t.string   "youtube_url",         :limit => 256
    t.string   "facebook_id",         :limit => 64
    t.string   "fax",                 :limit => 20
    t.integer  "votesmart_id"
    t.integer  "govtrack_id"
    t.string   "bioguide_id",         :limit => 32
    t.string   "eventful_id",         :limit => 64
    t.string   "photo_extension",     :limit => 20
    t.string   "rss",                 :limit => 256
    t.string   "open_states_leg_id",  :limit => 20
    t.string   "external_photo_url"
    t.string   "transparencydata_id", :limit => 32
    t.datetime "source_created_at"
    t.datetime "source_updated_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "officials", ["bioguide_id"], :name => "officials_bioguide_uidx", :unique => true
  add_index "officials", ["facebook_id"], :name => "officials_facebook_uidx", :unique => true
  add_index "officials", ["last_name", "first_name", "middle_name"], :name => "officials_name_idx"
  add_index "officials", ["open_states_leg_id"], :name => "officials_open_states_leg_uidx", :unique => true
  add_index "officials", ["votesmart_id"], :name => "officials_votesmart_uidx", :unique => true

  create_table "parties", :id => false, :force => true do |t|
    t.integer "id",                         :null => false
    t.string  "name",         :limit => 32, :null => false
    t.string  "member_noun",  :limit => 32, :null => false
    t.string  "abbreviation", :limit => 6,  :null => false
  end

  create_table "polity_types", :force => true do |t|
    t.string "name", :limit => 32, :null => false
  end

  add_index "polity_types", ["name"], :name => "polity_types_uidx"

  create_table "poll_workflow_states", :force => true do |t|
    t.string "name", :limit => 32, :null => false
  end

  create_table "question_votes", :force => true do |t|
    t.integer  "question_id",              :null => false
    t.integer  "user_id",                  :null => false
    t.integer  "direction",   :limit => 2, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "question_votes", ["question_id", "user_id"], :name => "question_votes_uidx", :unique => true

  create_table "questions", :force => true do |t|
    t.integer  "official_id",                :null => false
    t.integer  "user_id",                    :null => false
    t.text     "title",                      :null => false
    t.text     "body",                       :null => false
    t.text     "answer"
    t.integer  "up_cache",    :default => 0, :null => false
    t.integer  "down_cache",  :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "quick_poll_options", :force => true do |t|
    t.string   "text",          :limit => 32, :null => false
    t.integer  "quick_poll_id",               :null => false
    t.integer  "value",         :limit => 2,  :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "quick_poll_options", ["quick_poll_id", "value"], :name => "quick_poll_options_uidx", :unique => true

  create_table "quick_poll_responses", :id => false, :force => true do |t|
    t.integer "quick_poll_id",              :null => false
    t.integer "user_id",                    :null => false
    t.integer "value",         :limit => 2, :null => false
  end

  add_index "quick_poll_responses", ["user_id"], :name => "quick_poll_responses_user_idx"

  create_table "quick_poll_types", :force => true do |t|
    t.string "name", :limit => 32, :null => false
  end

  create_table "quick_poll_unregistered_responses", :id => false, :force => true do |t|
    t.integer "quick_poll_id",              :null => false
    t.integer "value",         :limit => 2, :null => false
    t.text    "uid",                        :null => false
  end

  create_table "quick_polls", :force => true do |t|
    t.string   "title",                  :limit => 64, :null => false
    t.text     "body",                                 :null => false
    t.integer  "quick_poll_type_id",                   :null => false
    t.integer  "poll_workflow_state_id",               :null => false
    t.integer  "issue_id",                             :null => false
    t.integer  "graph_type_id",                        :null => false
    t.datetime "start_time",                           :null => false
    t.datetime "end_time",                             :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "quick_polls", ["end_time"], :name => "quick_polls_end_time_idx"
  add_index "quick_polls", ["issue_id"], :name => "quick_polls_issue_idx"
  add_index "quick_polls", ["start_time"], :name => "quick_polls_start_time_idx"

  create_table "sessions", :force => true do |t|
    t.text "session_id"
    t.text "data"
  end

  create_table "site_roles", :force => true do |t|
    t.string "name", :limit => 20, :null => false
  end

  add_index "site_roles", ["name"], :name => "site_role_name_uidx", :unique => true

  create_table "standard_poll_option_sets", :force => true do |t|
    t.string   "name",       :limit => 32, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "standard_poll_option_sets", ["name"], :name => "standard_poll_option_sets_name_uidx", :unique => true

  create_table "standard_poll_options", :force => true do |t|
    t.integer  "standard_poll_option_set_id",               :null => false
    t.string   "text",                        :limit => 32, :null => false
    t.integer  "value",                                     :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "standard_poll_options", ["standard_poll_option_set_id", "text"], :name => "standard_poll_options_text_uidx", :unique => true
  add_index "standard_poll_options", ["standard_poll_option_set_id", "value"], :name => "standard_poll_options_value_uidx", :unique => true

  create_table "state_house_districts", :id => false, :force => true do |t|
    t.integer  "state_id",                 :null => false
    t.string   "district",   :limit => 64, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "state_senate_districts", :id => false, :force => true do |t|
    t.integer  "state_id",                 :null => false
    t.string   "district",   :limit => 64, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "states", :id => false, :force => true do |t|
    t.integer "id",                                          :null => false
    t.text    "name",                                        :null => false
    t.string  "abbreviation", :limit => 2,                   :null => false
    t.boolean "is_state",                  :default => true, :null => false
  end

  add_index "states", ["abbreviation"], :name => "states_abbreviation_uidx", :unique => true
  add_index "states", ["name"], :name => "states_name_uidx", :unique => true

  create_table "sunlight_congress_import", :id => false, :force => true do |t|
    t.text    "title"
    t.text    "firstname"
    t.text    "middlename"
    t.text    "lastname"
    t.text    "name_suffix"
    t.text    "nickname"
    t.text    "party"
    t.text    "state"
    t.text    "district"
    t.integer "in_office"
    t.text    "gender"
    t.text    "phone"
    t.text    "fax"
    t.text    "website"
    t.text    "webform"
    t.text    "congress_office"
    t.text    "bioguide_id"
    t.integer "votesmart_id"
    t.text    "fec_id"
    t.integer "govtrack_id"
    t.text    "crp_id"
    t.text    "twitter_id"
    t.text    "congresspedia_url"
    t.text    "youtube_url"
    t.text    "facebook_id"
    t.text    "official_rss"
    t.text    "senate_class"
    t.date    "birthdate"
  end

  create_table "taggable_types", :id => false, :force => true do |t|
    t.string "type", :limit => 32, :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "tag",           :limit => 32,                     :null => false
    t.string   "context",       :limit => 32, :default => "main", :null => false
    t.string   "taggable_type", :limit => 32,                     :null => false
    t.integer  "taggable_id",                                     :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "tags", ["tag", "context", "taggable_type", "taggable_id"], :name => "tags_uidx", :unique => true
  add_index "tags", ["taggable_type", "taggable_id"], :name => "tags_taggable_idx"

  create_table "terms", :force => true do |t|
    t.string   "name",           :limit => 40
    t.date     "from_date",                    :null => false
    t.date     "to_date",                      :null => false
    t.boolean  "standard",                     :null => false
    t.integer  "office_type_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "terms", ["from_date"], :name => "terms_from_date_idx"
  add_index "terms", ["office_type_id"], :name => "terms_office_type_idx"
  add_index "terms", ["to_date"], :name => "terms_to_date_idx"

# Could not dump table "users" because of following StandardError
#   Unknown type 'sex' for column 'sex'

  create_table "wards", :id => false, :force => true do |t|
    t.integer  "state_id",                             :null => false
    t.integer  "municipality_ansi_code",               :null => false
    t.string   "ward",                   :limit => 32, :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

end
