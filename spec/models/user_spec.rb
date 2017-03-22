require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#refresh_tokens" do
    it "returns a new token for a user" do
      VCR.use_cassette("/models/refresh_token_for_user") do
        user = Fabricate(:user,
                         access_token: ENV['ACCESS_TOKEN_DUMMY'],
                         refresh_token: ENV['REFRESH_TOKEN_DUMMY'])
        new_access_token = user.refresh_tokens

        expect(new_access_token.class).to eq(String)
        expect(new_access_token).to_not eq(ENV['ACCESS_TOKEN_DUMMY'])
        expect(user.access_token).to_not eq(ENV['ACCESS_TOKEN_DUMMY'])
        expect(user.access_token).to eq(new_access_token)
      end
    end
  end

  describe "#subreddit_subscriptions" do
    it "returns a collection of subreddits a user is subscribed to" do
      VCR.use_cassette("/models/subreddits_for_user") do
        user = Fabricate(:user,
                         access_token: ENV['UPDATED_DUMMY_TOKEN'],
                         refresh_token: ENV['REFRESH_TOKEN_DUMMY'])
        subreddits = user.subreddit_subscriptions
        subreddit = subreddits.first
        expect(subreddit.class).to eq(Subreddit)
      end
    end
  end
end
