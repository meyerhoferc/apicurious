require 'rails_helper'

describe Post do
  describe "#update_attributes" do
    it "updates all attributes for a post" do
      VCR.use_cassette("/models/update_subreddit_information", allow_playback_repeats: true) do
        post = Post.new(id: "5wt8jd", subreddit: "tucson")
        text = "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;&lt;strong&gt;ALL classified-type posts must be posted in this thread and not in the main sub.&lt;/strong&gt;&lt;/p&gt;\n\n&lt;p&gt;Topics that are appropriate for this thread include:&lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;Buy/Sell/Trade of: propery, vehicles, goods (&lt;em&gt;nothing illegal&lt;/em&gt;)&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Cross posts from Craigslist&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Roommate(s) wanted/needed&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Sublets/vacancies available&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Residential and/or commercial real estate for sale/lease&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Questions about neighborhoods/where to live or rent&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Garage sale announcements&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Job seekers/employers looking to hire&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Self-promotion (businesses, including artists, musicians, etc sharing their work)&lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n\n&lt;hr/&gt;\n\n&lt;p&gt;For selling items, please remember to list some of the basics for potential buyers:&lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;Price&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Item details (condition, date of purchase, etc.)&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Your general location (Tucson, Oro Valley, Marana, etc.  No addresses, save that for PM.)&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Anything else that&amp;#39;s relevant&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;&lt;strong&gt;Nothing illegal is allowed&lt;/strong&gt;&lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n\n&lt;hr/&gt;\n\n&lt;p&gt;All posts of this nature will be directed out of the main sub and into this thread.  If you think you have a compelling reason to post in the main sub, please message the mods and we will evaluate the request.  Thanks!&lt;/p&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;"

        post.update_attributes
        expect(post.title).to eq("Buy/Sell/Trade/Housing: March 2017")
        expect(post.num_comments).to eq(31)
        expect(post.score).to eq(10)
        expect(post.author).to eq("CompletelyLurker")
        expect(post.url).to eq("https://www.reddit.com/r/Tucson/comments/5wt8jd/buyselltradehousing_march_2017/")
        expect(post.text).to eq(text)
      end
    end
  end

  describe "#comments" do
    it "returns a trie of all comments for a post" do
      VCR.use_cassette("/models/update_subreddit_information", allow_playback_repeats: true) do
        post = Post.new(id: "5wt8jd", subreddit: "tucson")
        post.fetch_comments
        parent_comments = post.comments
        top_comment = parent_comments[0]
        expect(parent_comments.class).to eq(Array)
        expect(parent_comments.first.class).to eq(Comment)
        expect(top_comment.body).to eq("Looking to rent 2 or 3 bedroom house/condo/townhouse or apartment --Central Tucson, April 1. Not too picky $1100 limit")
      end
    end
  end
end
