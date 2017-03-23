require 'rails_helper'

describe "user visits subreddit show page" do
  describe "it can view an individual post" do
    it "and see post features displayed" do
      VCR.use_cassette("/features/view_post_on_a_subreddit") do
        tucson_subreddit = Subreddit.new("tucson", '/r/tucson', "tucson things")
        pics_subreddit = Subreddit.new("pics", '/r/pics', "pic things")
        subreddits = [tucson_subreddit, pics_subreddit]
        user = Fabricate(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(User).to receive(:subreddit_subscriptions).and_return(subreddits)

        visit subreddit_path(tucson_subreddit.title)

        click_on "Buy/Sell/Trade/Housing: March 2017"

        expect(current_path).to eq(subreddit_post_path(tucson_subreddit.title, "5wt8jd"))

        within(".title") do
          expect(page).to have_link("Buy/Sell/Trade/Housing: March 2017")
        end

        within ("#author") do
          expect(page).to have_content("CompletelyLurker")
        end

        within("#comments") do
          expect(page).to have_content("31 comments")
        end
      end
    end
  end
end
