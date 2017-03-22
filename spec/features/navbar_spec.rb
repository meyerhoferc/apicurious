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

  it "as a logged in user" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within(".nav-wrapper") do
      expect(page).to have_link("Reddit Curious")
      expect(page).to have_link("Logout")
      expect(page).to have_link(user.username)
      expect(page).to_not have_link("Login with Reddit")
    end

    click_on "/u/#{user.username}"

    within(".nav-wrapper") do
      expect(page).to have_link("Reddit Curious")
      expect(page).to have_link("Logout")
      expect(page).to have_link(user.username)
      expect(page).to_not have_link("Login with Reddit")
    end

    click_on "Reddit Curious"

    expect(current_path).to eq(root_path)
  end
end
