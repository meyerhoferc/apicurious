require 'rails_helper'

describe "navbar" do
  it "for a visitor" do
    user = Fabricate(:user)
    visit root_path

    within(".nav-wrapper") do
      expect(page).to have_link("Reddit Curious")
      expect(page).to have_link("Login with Reddit")
      expect(page).to_not have_link(user.username)
    end

    click_on "Reddit Curious"

    expect(current_path).to eq(root_path)

    visit dashboard_path

    expect(current_path).to eq(root_path)
  end
end
