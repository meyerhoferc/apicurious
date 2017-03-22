require 'rails_helper'

describe "homepage" do
  describe "a user not logged in visits the homepage" do
    it "they see a button to log in with reddit" do
      visit root_path

      within("h1") do
        expect(page).to have_content("Login with Reddit to view your Reddit feed")
      end
    end
  end

  describe "a logged in user visits the homepage" do
    it "they see a list of their subscribed subreddits" do
      user = Fabricate(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit root_path

      within("h1") do
        expect(page).to have_content("#{user.username}'s Subreddits")
        expect(page).to_not have_content("Login with Reddit to view your Reddit feed")
      end
    end
  end
end
