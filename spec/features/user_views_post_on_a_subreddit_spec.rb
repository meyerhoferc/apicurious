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

        body = "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;&lt;strong&gt;ALL classified-type posts must be posted in this thread and not in the main sub.&lt;/strong&gt;&lt;/p&gt;\n\n&lt;p&gt;Topics that are appropriate for this thread include:&lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;Buy/Sell/Trade of: propery, vehicles, goods (&lt;em&gt;nothing illegal&lt;/em&gt;)&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Cross posts from Craigslist&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Roommate(s) wanted/needed&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Sublets/vacancies available&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Residential and/or commercial real estate for sale/lease&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Questions about neighborhoods/where to live or rent&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Garage sale announcements&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Job seekers/employers looking to hire&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Self-promotion (businesses, including artists, musicians, etc sharing their work)&lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n\n&lt;hr/&gt;\n\n&lt;p&gt;For selling items, please remember to list some of the basics for potential buyers:&lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;Price&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Item details (condition, date of purchase, etc.)&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Your general location (Tucson, Oro Valley, Marana, etc.  No addresses, save that for PM.)&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Anything else that&amp;#39;s relevant&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;&lt;strong&gt;Nothing illegal is allowed&lt;/strong&gt;&lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n\n&lt;hr/&gt;\n\n&lt;p&gt;All posts of this nature will be directed out of the main sub and into this thread.  If you think you have a compelling reason to post in the main sub, please message the mods and we will evaluate the request.  Thanks!&lt;/p&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;"

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

        within(".body") do
          expect(page).to have_content(body)
        end

        within(".rules") do
          expect(page).to have_content("No posting anything that violates reddit's spam or advertising policies.")
          expect(page).to have_content("Being abusive")
          expect(page).to have_content("No identifying info or attempts to find info on someone else.")
          expect(page).to have_content("Not a credible news source OR misleading title")
        end
      end
    end
  end
end
