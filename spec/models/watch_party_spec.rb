# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WatchParty, type: :model do
  describe 'relationships' do
    it { should have_many(:users_watch_parties) }
    it { should have_many(:users).through(:users_watch_parties) }
  end
end
