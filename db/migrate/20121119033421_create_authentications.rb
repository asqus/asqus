class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id, :null => false
      t.string :provider, :null => false
      t.string :uid, :null => false
      t.string :token, :null => false

      t.timestamps
    end
    add_index :authentications, :user_id
    add_index :authentications, :token
    add_index :authentications, :uid
  end
end
