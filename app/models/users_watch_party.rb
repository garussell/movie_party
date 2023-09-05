class UsersWatchParty < ApplicationRecord
  belongs_to :user
  belongs_to :watch_party
end