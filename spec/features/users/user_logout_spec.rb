require 'rails_helper'

describe "User Log Out" do
  before do
    @user = User.create!(name: 'Bob', email: 'pockets@gmail.com', password: '123123', password_confirmation: '123123')
    
    visit login_path
    fill_in :password, with: '123123'
    fill_in :email, with: 'pockets@gmail.com'
    click_on 'Log In'
  end

  describe "as a user" do
    describe "when I visit the landing page" do
      it "I no longer see a link to log in or create an account, but I see a link to Log Out. When I click the link to Log Out, I'm taken back to the landing page and I can see that the Log Out link has changed back to a Log In link" do
        expect(page).to have_current_path(welcome_index_path)
        
        expect(page).to have_link("Log Out")
        expect(page).to_not have_link("Log In")

        click_on "Log Out"

        expect(page).to have_current_path(root_path)
        expect(page).to_not have_link("Log Out")
        expect(page).to have_link("Log In")
      end
    end
  end
end