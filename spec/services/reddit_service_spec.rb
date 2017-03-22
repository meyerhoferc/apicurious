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
end
