class CreateUsersWatchParties < ActiveRecord::Migration[7.0]
  def change
    create_table :users_watch_parties do |t|
      t.bigint :user_id, null: false
      t.bigint :watch_party_id, null: false
      t.timestamps
    end

    add_index :users_watch_parties, :user_id
    add_index :users_watch_parties, :watch_party_id
  end
end
