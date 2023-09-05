# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users discover path' do
  before do
    @user_1 = User.create!(name: 'Ringo', email: 'ringo@gmail.com')

    visit user_discover_index_path(@user_1)
  end

  describe 'as a user', :vcr do
    describe "when I visit the '/users/:id/discover' path" do
      it 'I should see a button to discover top rated movies and a text field to search' do
        expect(page).to have_button('Find Top Rated Movies')
        expect(page).to have_field(:title)
        expect(page).to have_button('Find Movies')
      end

      it 'when the user clicks on the find top rated movies they should be taken to the movies results page' do
        click_on 'Find Top Rated Movies'

        expect(page).to have_current_path(user_movies_path(@user_1))
        expect(page).to have_link('Elemental')
        expect(page).to have_content('Vote Average')
      end

      it 'when the user clicks on Find Movies, they should be taken to the movies results page' do
        fill_in :title, with: 'Harry Potter'

        click_on 'Find Movies'

        expect(page).to have_content("Harry Potter and the Philosopher's Stone")
      end

      it 'also has a button to return to the Discover Page' do
        click_on 'Find Top Rated Movies'
        expect(page).to have_button('Discover Page')

        click_on 'Discover Page'
        expect(page).to have_current_path(user_discover_index_path(@user_1))

        fill_in :title, with: 'Harry Potter'
        click_on 'Find Movies'
        expect(page).to have_button('Discover Page')

        click_on 'Discover Page'
        expect(page).to have_current_path(user_discover_index_path(@user_1))
      end
    end
  end
end
