# frozen_string_literal: true

class DropUsersWatchParties < ActiveRecord::Migration[7.0]
  def change
    drop_table :users_watch_parties
  end
end
