# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:password)}
    it { should have_secure_password }
  end

  describe 'relationships' do
    it { should have_many(:users_watch_parties) }
    it { should have_many(:watch_parties).through(:users_watch_parties) }
  end
end
