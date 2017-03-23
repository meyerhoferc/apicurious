require 'rails_helper'

describe Subreddit do
  describe "#update_url" do
    it "updates the url attribute for a subreddit" do
      VCR.use_cassette("/models/update_url_attribute_subreddit") do
        subreddit = Subreddit.new("tucson")
        expect(subreddit.url).to eq(nil)
        subreddit.update_url
        expect(subreddit.url).to eq("/r/Tucson/")
      end
    end
  end

  describe "#update_description" do
    it "updates the description attribute for a subreddit" do
      VCR.use_cassette("/models/update_description_subreddit") do
        subreddit = Subreddit.new("tucson")
        expect(subreddit.description).to eq(nil)
        description = "The subreddit for Tucson, Arizona; located in the Southwestern part of the US.  Southern Arizona is 70 miles north of Mexico, on I-10 between California and New Mexico. We have plenty of cacti and beautiful scenery to enjoy!"
        subreddit.update_description
        expect(subreddit.description).to eq(description)
      end
    end
  end

  describe "#rules" do
    it "returns a collection of rules for that subreddit" do
      VCR.use_cassette("/models/rules_for_subreddit") do
        subreddit = Subreddit.new("tucson")
        subreddit.get_rules
        rules = subreddit.rules
        expect(rules.count).to eq(4)
        expect(rules.first.content).to eq("No posting anything that violates reddit's spam or advertising policies.")
      end
    end
  end

  describe "#welcome_message" do
    it "returns the about message for a subreddit" do
      VCR.use_cassette("/models/about_message_for_subreddit") do
        subreddit = Subreddit.new("tucson")
        message = subreddit.welcome_message
        expected =  "###\n\n###\n\n***\n\nWelcome to /r/Tucson, the subreddit for content pertaining to the Tucson Metropolitan area including: *Tucson, Marana, Vail, Oro Valley, Green Valley &amp; Sahuarita*. \n\n###\n\n###\n\n***\n\n#**Please follow some basic rules:**\n\n&gt;#**(*Hover to expand*)**\n\n&gt;* **Please always follow [**Redditquette**](http://www.reddit.com/wiki/reddiquette)!**  \n\n&gt; * **Racism, sexism, homophobia, abuse, or any other hatred or trolling will result in a ban.**\n\n&gt;* **No advertising spam.**  *See [reddit's rules](https://www.reddit.com/rules) for more information.  If you stand to profit from anything you post in any way, shape, or form, it violates reddit's rules and our rules.*\n\n&gt;* **News should come from actual news sources, not blogs or Facebook.**  Please use the article's actual title for your post title.\n\n&gt;* **Do not post any personal information.**  *That includes yours or anyone else's and license plates should be blurred.*\n\n&gt;* **No stolen goods posts, please.**  *Make sure you file a police report if your item(s) go missing.*\n\n&gt;* **Missing Persons posts are allowed only when accompanied by a credible news source.**  Charity fundraisers must go directly to the charity via their website.  No personal fundraisers.\n\n&gt;* **Moderators reserve the right to remove any post or comment at our discretion.**\n\n****\n\n###**Tucson Reddit**\n\n####[Monthly Buy/Sell/Trade](http://www.reddit.com/r/Tucson/search?q=buy%2Fsell%2Ftrade&amp;restrict_sr=on&amp;sort=relevance&amp;t=all)\n\n####[/r/TucsonMeetup](http://www.reddit.com/r/TucsonMeetup)\n\n####[/r/TucsonJobs](http://www.reddit.com/r/TucsonJobs)\n\n\n****\n\n###**Tucson Social Groups**\n\n####[/r/Tucson Facebook page](http://www.facebook.com/home.php?sk=group_185849614764493)\n\n####[Arizona IRC chat](https://kiwiirc.com/client/irc.freenode.net/?nick=Arizonan%7C?##arizona)\n\n****\n\n###**Arizona State and Regional Subreddits**\n\n####/r/arizona \n####/r/UofArizona \n####/r/phoenix \n####/r/Flagstaff \n####/r/Prescott \n\n****\n\n###**Resources**\n\n####[/r/Tucson Traffic &amp; Visitor Stats](http://www.reddit.com/r/Tucson/about/traffic/)\n\n####[TEP Outage Map](https://www.tep.com/outage/map/)\n\n####[TPD Crime Mapping](http://www.tucsonaz.gov/police/statistics)\n\n***"
        expect(message).to eq(expected)
      end
    end
  end

  describe "#posts" do
    it "returns the 15 most recent posts in the 'hot' category" do
      VCR.use_cassette("/models/15_hot_posts_for_subreddit") do
        subreddit = Subreddit.new("tucson")
        posts = subreddit.posts
        expect(posts.count).to eq(15)
        expect(posts.first.class).to eq(Post)
        expect(posts.first.title).to eq("Buy/Sell/Trade/Housing: March 2017")
        expect(posts.first.num_comments).to eq(31)
        expect(posts.first.score).to eq(11)
        expect(posts.first.id).to eq("5wt8jd")
        expect(posts.first.subreddit.downcase).to eq("r/tucson")
      end
    end
  end
end
