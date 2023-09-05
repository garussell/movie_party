class WatchParty < ApplicationRecord
  has_many :users_watch_parties
  has_many :users, through: :users_watch_parties
end
