# frozen_string_literal: true

class AddColumnUserIdsToWatchParties < ActiveRecord::Migration[7.0]
  def change
    add_column :watch_parties, :user_ids, :integer, array: true
  end
end
