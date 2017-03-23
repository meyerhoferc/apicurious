require 'rails_helper'

describe "user visits subreddit show page" do
  describe "it can view an individual post" do
    it "and see post features displayed" do
      VCR.use_cassette("/features/view_post_on_a_subreddit", allow_playback_repeats: true) do
        tucson_subreddit = Subreddit.new("tucson")
        pics_subreddit = Subreddit.new("pics")
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

  describe "user can see the comments" do
    it "visually nested as replies" do
      VCR.use_cassette("/features/view_post_on_a_subreddit", allow_playback_repeats: true) do
        tucson_subreddit = Subreddit.new("tucson")
        pics_subreddit = Subreddit.new("pics")
        subreddits = [tucson_subreddit, pics_subreddit]
        user = Fabricate(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(User).to receive(:subreddit_subscriptions).and_return(subreddits)

        visit subreddit_path(tucson_subreddit.title)

        click_on "Buy/Sell/Trade/Housing: March 2017"
        expect(current_path).to eq(subreddit_post_path(tucson_subreddit.title, "5wt8jd"))

        comment_one = "its a 2014 vizio, no issues of note. In the effort of honesty it may actually be a 49 inch."
        comment_two = "Looking to rent 2 or 3 bedroom house/condo/townhouse or apartment --Central Tucson, April 1. Not too picky $1100 limit"

        within(".comments") do
          expect(page).to have_content("31 comments")
        end

        within("#comment_decv3ts") do
          expect(page).to have_content(comment_two)
        end

        within("#comment_dej0blu") do
          expect(page).to have_content(comment_one)
        end
      end
    end
  end
end
