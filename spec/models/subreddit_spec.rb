require 'rails_helper'

describe Subreddit do
  describe "#update_url" do
    it "updates the url attribute for a subreddit" do
      subreddit = Subreddit.new("tucson")
      expect(subreddit.url).to eq(nil)
      subreddit.update_url
      expect(subreddit.url).to eq("/r/Tucson/")
    end
  end

  describe "#update_description" do
    it "updates the description attribute for a subreddit" do
      subreddit = Subreddit.new("tucson")
      expect(subreddit.description).to eq(nil)
      description = "The subreddit for Tucson, Arizona; located in the Southwestern part of the US.  Southern Arizona is 70 miles north of Mexico, on I-10 between California and New Mexico. We have plenty of cacti and beautiful scenery to enjoy!"
      subreddit.update_description
      expect(subreddit.description).to eq(description)
    end
  end
end
