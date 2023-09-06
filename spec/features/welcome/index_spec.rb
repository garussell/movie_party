# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'root path' do
  before do
    @user_1 = User.create!(name: 'Ringo', email: 'ringo@gmail.com', password: '123456',
                           password_confirmation: '123456')
    visit login_path
    fill_in :password, with: '123456'
    fill_in :email, with: 'ringo@gmail.com'
    click_on 'Log In'

    visit welcome_index_path
  end

  describe 'as a user' do
    describe 'when I visit the root path' do
      it 'should have the title of application' do
        expect(page).to have_content('Movie Party')
      end

      it 'has a button to create a new user' do
        expect(page).to have_button('My Dashboard')
      end

      it 'has a list of existing users which are links to user dashboard' do
        expect(page).to have_content(@user_1.email)

        click_on 'My Dashboard'

        expect(page).to have_current_path(user_path(@user_1))
      end

      it 'links back to the landing page (at the top of all pages)' do
        expect(page).to have_button('Home')

        click_on 'Home'

        expect(page).to have_current_path(user_path(@user_1))
      end
    end
  end
end
