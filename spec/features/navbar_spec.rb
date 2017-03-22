require 'rails_helper'

describe "navbar" do
  it "for a visitor" do
    Fabricate(:user)
    visit root_path

    within(".navbar") do
      expect(page).to have_link("Reddit Curious")
      expect(page).to have_link("Login with Reddit")
      expect(page).to_not have_link(user.username)
    end

    click_on "Login with Reddit"

    expect(current_path).to eq("https://www.reddit.com/api/v1/authorize?client_id=#{ENV['REDDIT_KEY']}&response_type=code&state=RANDOM_STRING&redirect_uri=#{ENV['REDIRECT_URI']}&duration=permanent&scope=identity,mysubreddits,read")

    click_on "Reddit Curious"

    expect(current_path).to eq(root_path)

    visit dashboard_path

    expect(current_path).to eq(root_path)
  end
end
