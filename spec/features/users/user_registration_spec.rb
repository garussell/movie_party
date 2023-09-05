require 'rails_helper'

RSpec.describe "User Registration Form" do
  before do

  end

  describe "as a user" do
    describe "when I visit '/registrations'" do
      it "has a form to create a new user" do
        visit registrations_path

        click_on "Register as a User" 

        expect(current_path).to eq(new_registration_path)

        username = "Pockets"
        password = "pa$$word"

        fill_in :name, with: username
        fill_in :user_password, with: password
        fill_in :user_password_confirmation, with: password
        fill_in :user_email, with: 'pockets@gmail.com'

        click_on "Register" 

        expect(page).to have_content("Welcome, pockets!")
      end
    end
  end
end