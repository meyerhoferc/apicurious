require 'rails_helper'

describe RedditService do
  attr_reader :service
  before(:each) do
    @service = RedditService.new(access_token)
  end

  describe "#subreddits" do
    it "finds all subreddits for a user" do
      subreddits = service.subreddits
      subreddit = subreddits.first
      expect(subreddit.class).to eq(Subreddit)
    end
  end
end
