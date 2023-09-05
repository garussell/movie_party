require 'rails_helper'

RSpec.describe "as a user" do
  before do
    @user = User.create!(name: "Bob", email: "pockets@gmail.com", password: '123123', password_confirmation: '123123')
  end

  describe "when I visit the landing page" do
    it "I see a link for 'Log In', when I click on 'Log In' I'm taken to a Log In page" do
      visit root_path

      expect(page).to have_link("Log In")

      click_on "Log In"

      expect(current_path).to eq(login_path)
    end

    it "where I can input my unique email and password, when I enter my unique email and correct password, I'm taken to my dashboard page" do
      visit login_path

      fill_in :password, with: '123123'
      fill_in :email, with: 'pockets@gmail.com'

      click_on "Log In"

      expect(page).to have_current_path(welcome_index_path)
      expect(page).to have_content("Welcome, Bob!")
    end
  end

  describe "when I enter invalid credentials" do
    it "throws an error telling me that I entered incorrect credentials" do
      visit login_path

      fill_in :password, with: '654321'
      fill_in :email, with: 'pockets@gmail.com'
      
      click_on "Log In"

      expect(page).to have_current_path(login_path)
      expect(page).to have_content("Wrong email or password.")
    end
  end
end