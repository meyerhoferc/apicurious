require 'rails_helper'

describe RedditService do
  describe "#subreddits" do
    it "finds all subreddits for a user" do
      VCR.use_cassette("/services/subreddits_for_user") do
        user = Fabricate(:user,
                         access_token: ENV['UPDATED_DUMMY_TOKEN'],
                         refresh_token: ENV['REFRESH_TOKEN_DUMMY'])
        service = RedditService.new(user.access_token)
        subreddits = service.subreddits
        subreddit = subreddits.first
        expect(subreddits.count).to eq(25)
        expect(subreddit.keys).to eq([:kind, :data])
      end
    end
  end

  describe "#get_subreddit_url(title)" do
    it "returns the url for a subreddit" do
      VCR.use_cassette("/services/get_subreddit_url") do
        subreddit = Subreddit.new("tucson")
        service = RedditService.new()
        url = service.get_subreddit_url(subreddit.title)
        expect(url).to eq("/r/Tucson/")
      end
    end
  end

  describe "#get_subreddit_description(title)" do
    it "returns the description for a subreddit" do
      VCR.use_cassette("/services/get_subreddit_description") do
        subreddit = Subreddit.new("tucson")
        service = RedditService.new()
        description = service.get_subreddit_description(subreddit.title)
        expected = "The subreddit for Tucson, Arizona; located in the Southwestern part of the US.  Southern Arizona is 70 miles north of Mexico, on I-10 between California and New Mexico. We have plenty of cacti and beautiful scenery to enjoy!"
        expect(description).to eq(expected)
      end
    end
  end

  describe "#get_subreddit_rules(title)" do
    it "returns a collection of rules for a subreddit" do
      VCR.use_cassette("/services/get_subreddit_rules") do
        subreddit = Subreddit.new("tucson")
        service = RedditService.new()
        rules = service.get_subreddit_rules(subreddit.title)
        expect(rules.count).to eq(4)
        expect(rules.first[:description]).to eq("No posting anything that violates reddit's spam or advertising policies.")
      end
    end
  end

  describe "#get_subreddit_about(title)" do
    it "returns the about message for a subreddit" do
      VCR.use_cassette("/services/get_subreddit_about") do
        subreddit = Subreddit.new("tucson")
        service = RedditService.new()
        message = service.get_subreddit_about(subreddit.title)
        expected =  "###\n\n###\n\n***\n\nWelcome to /r/Tucson, the subreddit for content pertaining to the Tucson Metropolitan area including: *Tucson, Marana, Vail, Oro Valley, Green Valley &amp; Sahuarita*. \n\n###\n\n###\n\n***\n\n#**Please follow some basic rules:**\n\n&gt;#**(*Hover to expand*)**\n\n&gt;* **Please always follow [**Redditquette**](http://www.reddit.com/wiki/reddiquette)!**  \n\n&gt; * **Racism, sexism, homophobia, abuse, or any other hatred or trolling will result in a ban.**\n\n&gt;* **No advertising spam.**  *See [reddit's rules](https://www.reddit.com/rules) for more information.  If you stand to profit from anything you post in any way, shape, or form, it violates reddit's rules and our rules.*\n\n&gt;* **News should come from actual news sources, not blogs or Facebook.**  Please use the article's actual title for your post title.\n\n&gt;* **Do not post any personal information.**  *That includes yours or anyone else's and license plates should be blurred.*\n\n&gt;* **No stolen goods posts, please.**  *Make sure you file a police report if your item(s) go missing.*\n\n&gt;* **Missing Persons posts are allowed only when accompanied by a credible news source.**  Charity fundraisers must go directly to the charity via their website.  No personal fundraisers.\n\n&gt;* **Moderators reserve the right to remove any post or comment at our discretion.**\n\n****\n\n###**Tucson Reddit**\n\n####[Monthly Buy/Sell/Trade](http://www.reddit.com/r/Tucson/search?q=buy%2Fsell%2Ftrade&amp;restrict_sr=on&amp;sort=relevance&amp;t=all)\n\n####[/r/TucsonMeetup](http://www.reddit.com/r/TucsonMeetup)\n\n####[/r/TucsonJobs](http://www.reddit.com/r/TucsonJobs)\n\n\n****\n\n###**Tucson Social Groups**\n\n####[/r/Tucson Facebook page](http://www.facebook.com/home.php?sk=group_185849614764493)\n\n####[Arizona IRC chat](https://kiwiirc.com/client/irc.freenode.net/?nick=Arizonan%7C?##arizona)\n\n****\n\n###**Arizona State and Regional Subreddits**\n\n####/r/arizona \n####/r/UofArizona \n####/r/phoenix \n####/r/Flagstaff \n####/r/Prescott \n\n****\n\n###**Resources**\n\n####[/r/Tucson Traffic &amp; Visitor Stats](http://www.reddit.com/r/Tucson/about/traffic/)\n\n####[TEP Outage Map](https://www.tep.com/outage/map/)\n\n####[TPD Crime Mapping](http://www.tucsonaz.gov/police/statistics)\n\n***"
        expect(message).to eq(expected)
      end
    end
  end
end
