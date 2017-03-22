require 'rails_helper'

describe "user can logout" do
  it "from the user show page" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within(".nav-wrapper") do
      click_on("Logout")
    end

    within(".notice") do
      expect(page).to have_content("Successfully logged out")
    end

    expect(current_path).to eq(root_path)
  end

  it "from the root path" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within(".nav-wrapper") do
      click_on("Logout")
    end

    within(".notice") do
      expect(page).to have_content("Successfully logged out")
    end

    expect(current_path).to eq(root_path)
  end
end
