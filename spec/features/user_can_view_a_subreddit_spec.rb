require 'rails_helper'

describe "user can view a subreddit" do
  it "and all of its related content" do
    tucson_subreddit = Subreddit.new("tucson", '/r/tucson', "tucson things")
    pics_subreddit = Subreddit.new("pics", '/r/pics', "pic things")
    subreddits = [tucson_subreddit, pics_subreddit]
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(User).to receive(:subreddit_subscriptions).and_return(subreddits)
    visit root_path
    expect(page).to have_link("/r/Tucson")
    expect(page).to have_link("/r/pics")

    click_on "/r/Tucson"

    expect(current_path).to eq(subreddit_path(tucson_subreddit))

    within(".rules") do
      expect(page).to have_content("No posting anything that violates reddit's spam or advertising policies.")
      expect(page).to have_content("Being abusive")
      expect(page).to have_content("No identifying info or attempts to find info on someone else.")
      expect(page).to have_content("Not a credible news source OR misleading title")
    end

    within(".about") do
      expect(page).to have_content("###\n\n###\n\n***\n\nWelcome to /r/Tucson, the subreddit for content pertaining to the Tucson Metropolitan area including: *Tucson, Marana, Vail, Oro Valley, Green Valley &amp; Sahuarita*.")
    end
  end
end
