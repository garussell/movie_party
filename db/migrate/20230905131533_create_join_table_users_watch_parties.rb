class CreateJoinTableUsersWatchParties < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :watch_parties do |t|
      # t.index [:user_id, :watch_party_id]
      # t.index [:watch_party_id, :user_id]
    end
  end
end
