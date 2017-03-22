require 'rails_helper'

describe Subreddit do
  describe ".update_url" do
    it "updates the url attribute for a subreddit" do
      subreddit = Subreddit.new("tucson")
      expect(subreddit.url).to eq(nil)
      subreddit.update_url
      expect(subreddit.url).to eq("/r/Tucson/")
    end
  end
end
