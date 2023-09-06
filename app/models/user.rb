# frozen_string_literal: true

class User < ApplicationRecord
  has_many :users_watch_parties
  has_many :watch_parties, through: :users_watch_parties

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  has_secure_password

  enum role: %w[default admin]
end
