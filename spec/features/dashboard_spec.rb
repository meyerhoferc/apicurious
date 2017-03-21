require 'rails_helper'

describe "user dashboard path" do
  it "a user sees their information" do
    user = Fabricate(:user, username: "d117", comment_karma: "12", link_karma: "10")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    
    within("h1") do
      expect(page).to have_content("Welcome, d117")
    end
    within(".karma") do
      expect(page).to have_content("Comment Karma: 12")
      expect(page).to have_content("Link Karma: 10")
    end
  end
end
