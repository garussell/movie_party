# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersWatchParty, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :watch_party }
  end
end
