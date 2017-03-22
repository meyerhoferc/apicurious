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
end
