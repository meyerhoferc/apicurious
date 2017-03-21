require 'rails_helper'

describe "a user visits the homepage" do
  it "they see a button to log in with reddit" do
    visit root_path

    within("h1") do
      expect(page).to have_content("Login with Reddit to view your Reddit feed")
    end

    within(".button") do
      expect(page).to have_content("Login with Reddit")
    end
  end
end
