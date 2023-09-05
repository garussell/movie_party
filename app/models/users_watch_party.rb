# frozen_string_literal: true

class UsersWatchParty < ApplicationRecord
  belongs_to :user
  belongs_to :watch_party
end
