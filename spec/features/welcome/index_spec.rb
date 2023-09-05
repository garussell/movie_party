# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'root path' do
  before do
    @user_1 = User.create!(name: 'Ringo', email: 'ringo@gmail.com')

    visit welcome_index_path
  end

  describe 'as a user' do
    describe 'when I visit the root path' do
      it 'should have the title of application' do
        expect(page).to have_content('Watch Party Application')
      end

      it 'has a button to create a new user' do
        expect(page).to have_button('Create New User')
      end

      it 'has a list of existing users which are links to user dashboard' do
        expect(page).to have_link(@user_1.email)

        click_on @user_1.email

        expect(page).to have_current_path(user_path(@user_1))
      end

      it 'links back to the landing page (at the top of all pages)' do
        expect(page).to have_button('Home')

        click_on 'Home'

        expect(page).to have_current_path(welcome_index_path)
      end
    end
  end
end
