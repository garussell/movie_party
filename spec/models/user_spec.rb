# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it { should have_many(:users_watch_parties) }
    it { should have_many(:watch_parties).through(:users_watch_parties) }
  end
end
